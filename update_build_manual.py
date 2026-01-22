#!/usr/bin/env python3
import json
import xml.etree.ElementTree as ET
from pathlib import Path

base_dir = Path(__file__).resolve().parent
xml_path = base_dir / "build_manual" / "DGRGUI.xml"

pkg_name = "DGRGUI"

src_alias_dir = base_dir / "src" / "aliases" / "DGRGUI" / "EMCO"
src_script_dir = base_dir / "src" / "scripts" / "DGRGUI" / "EMCO"
src_trigger_dir = base_dir / "src" / "triggers" / "DGRGUI" / "EMCO"

aliases_json = json.loads((src_alias_dir / "aliases.json").read_text(encoding="utf-8"))


def add_text(elem, tag, text=""):
    child = ET.SubElement(elem, tag)
    if text is not None:
        child.text = text
    return child


def add_script(parent, name, script_text):
    script_elem = ET.SubElement(parent, "Script", isActive="yes", isFolder="no")
    add_text(script_elem, "name", name)
    add_text(script_elem, "script", script_text)
    add_text(script_elem, "command")
    add_text(script_elem, "packageName", pkg_name)
    add_text(script_elem, "eventHandlerList")
    return script_elem


def add_alias(parent, name, script_text, regex):
    alias_elem = ET.SubElement(parent, "Alias", isActive="yes", isFolder="no")
    add_text(alias_elem, "name", name)
    add_text(alias_elem, "script", script_text)
    add_text(alias_elem, "command")
    add_text(alias_elem, "packageName", pkg_name)
    add_text(alias_elem, "regex", regex)
    return alias_elem


def add_trigger(parent, name, script_text, regex):
    trigger_elem = ET.SubElement(parent, "Trigger", isActive="yes", isFolder="no")
    add_text(trigger_elem, "name", name)
    add_text(trigger_elem, "script", script_text)
    add_text(trigger_elem, "command")
    add_text(trigger_elem, "packageName", pkg_name)
    regex_list = add_text(trigger_elem, "regexCodeList")
    regex_prop_list = add_text(trigger_elem, "regexCodePropertyList")
    add_text(regex_list, "string", regex)
    add_text(regex_prop_list, "integer", "1")
    return trigger_elem


root = ET.Element("MudletPackage", version="1.001")

# ScriptPackage
script_package = ET.SubElement(root, "ScriptPackage")
script_group = ET.SubElement(script_package, "ScriptGroup", isActive="yes", isFolder="yes")
add_text(script_group, "name", "DGRGUI")
add_text(script_group, "script")
add_text(script_group, "packageName", pkg_name)
add_text(script_group, "eventHandlerList")

# Parent README script
parent_readme = base_dir / "src" / "scripts" / "DGRGUI" / "README.lua"
if parent_readme.exists():
    add_script(script_group, "README", parent_readme.read_text(encoding="utf-8"))

# EMCO child group
emco_group = ET.SubElement(script_group, "ScriptGroup", isActive="yes", isFolder="yes")
add_text(emco_group, "name", "EMCO")
add_text(emco_group, "script")
add_text(emco_group, "packageName", pkg_name)

code_script = (src_script_dir / "Code.lua").read_text(encoding="utf-8")
add_script(emco_group, "Code", code_script.replace("@PKGNAME@", pkg_name))

scripts_json_path = src_script_dir / "scripts.json"
if scripts_json_path.exists():
    scripts_json = json.loads(scripts_json_path.read_text(encoding="utf-8"))
    for entry in scripts_json:
        name = entry.get("name")
        if name and name != "Code":
            script_path = src_script_dir / f"{name}.lua"
            if script_path.exists():
                add_script(emco_group, name, script_path.read_text(encoding="utf-8"))

# AliasPackage
alias_package = ET.SubElement(root, "AliasPackage")
alias_group = ET.SubElement(alias_package, "AliasGroup", isActive="yes", isFolder="yes")
add_text(alias_group, "name", "DGRGUI")
add_text(alias_group, "script")
add_text(alias_group, "packageName", pkg_name)

parent_alias_readme = base_dir / "src" / "aliases" / "DGRGUI" / "README.lua"
if parent_alias_readme.exists():
    add_alias(alias_group, "README", parent_alias_readme.read_text(encoding="utf-8"), "^__DGRGUI_README__$")

emco_alias_group = ET.SubElement(alias_group, "AliasGroup", isActive="yes", isFolder="yes")
add_text(emco_alias_group, "name", "EMCO")
add_text(emco_alias_group, "script")
add_text(emco_alias_group, "packageName", pkg_name)

for alias_def in aliases_json:
    name = alias_def["name"]
    regex = alias_def["regex"]
    filename = name.replace(" ", "_") + ".lua"
    script_path = src_alias_dir / filename
    if not script_path.exists():
        raise SystemExit(f"Missing alias source file: {script_path}")
    script_content = script_path.read_text(encoding="utf-8").replace("@PKGNAME@", pkg_name)
    add_alias(emco_alias_group, name, script_content, regex)

# TriggerPackage
trigger_package = ET.SubElement(root, "TriggerPackage")
trigger_group = ET.SubElement(trigger_package, "TriggerGroup", isActive="yes", isFolder="yes")
add_text(trigger_group, "name", "DGRGUI")
add_text(trigger_group, "script")
add_text(trigger_group, "packageName", pkg_name)

parent_trigger_readme = base_dir / "src" / "triggers" / "DGRGUI" / "README.lua"
if parent_trigger_readme.exists():
    add_trigger(trigger_group, "README", parent_trigger_readme.read_text(encoding="utf-8"), "^__DGRGUI_TRIGGERS_README__$")

emco_trigger_group = ET.SubElement(trigger_group, "TriggerGroup", isActive="yes", isFolder="yes")
add_text(emco_trigger_group, "name", "EMCO")
add_text(emco_trigger_group, "script")
add_text(emco_trigger_group, "packageName", pkg_name)

emco_trigger_readme = src_trigger_dir / "README.lua"
if emco_trigger_readme.exists():
    add_trigger(emco_trigger_group, "README", emco_trigger_readme.read_text(encoding="utf-8"), "^__DGRGUI_EMCO_TRIGGERS_README__$")

xml_declaration = "<?xml version='1.0' encoding='utf-8'?>\n"
xml_body = ET.tostring(root, encoding="unicode")
xml_path.write_text(xml_declaration + xml_body, encoding="utf-8")

print("Updated build_manual/DGRGUI.xml from src")
