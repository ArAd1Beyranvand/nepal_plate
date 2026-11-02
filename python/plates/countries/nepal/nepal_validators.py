"""Port of nepal_plate/lib/src/nepal_validators.dart. Hand-ported; codegen never overwrites this file."""
from __future__ import annotations

import re

from plates.core.validators.plate_validator import GatedPlateValidator, PlateEntry, PlateValidation

def _fail(pattern, value, reason):
    return None if re.fullmatch(pattern, value) else PlateValidation.invalid(reason)


class NepalValidator(GatedPlateValidator):
    gate_group = "number"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not entry.group("province"):
            return PlateValidation.invalid("Choose a province.")
        return (_fail("[A-K][1-5]?", entry.group("class"),
                      "The class is a letter A to K, with a digit for a sub-class.")
                or _fail("[A-Z]{2}", entry.group("series"), "The series is two letters.")
                or _fail("[0-9]{4}", entry.group("number"), "The number is 4 digits.")
                or PlateValidation.valid())


class NepalLegacyValidator(GatedPlateValidator):
    gate_group = "number"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        if not entry.group("zone"):
            return PlateValidation.invalid("Choose a zone.")
        if not re.fullmatch("[0-9]{1,2}", entry.group("lot")):
            return PlateValidation.invalid("The lot is 1 or 2 digits.")
        if not entry.group("class"):
            return PlateValidation.invalid("Choose a class letter.")
        return _fail("[0-9]{4}", entry.group("number"), "The number is 4 digits.") or PlateValidation.valid()


class NepalDiplomaticValidator(GatedPlateValidator):
    gate_group = "serial"

    def judge(self, entry: PlateEntry) -> PlateValidation:
        return (_fail("[0-9]{1,2}", entry.group("country"), "The country number is 1 or 2 digits.")
                or _fail("[0-9]{1,2}", entry.group("serial"), "The serial is 1 or 2 digits.")
                or PlateValidation.valid())
