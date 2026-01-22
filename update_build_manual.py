#!/usr/bin/env python3
import json
import xml.etree.ElementTree as ET
from pathlib import Path

base_dir = Path(__file__).resolve().parent
xml_path = base_dir / "build_manual" / "DGRGUI.xml"

pkg_name = "DGRGUI"

src_alias_dir = base_dir / "src" / "aliases" / "DGRGUI" / "EMCO"
src_gui_alias_dir = base_dir / "src" / "aliases" / "DGRGUI"
src_script_dir_emco = base_dir / "src" / "scripts" / "EMCO"
src_script_dir_gui = base_dir / "src" / "scripts" / "DGRGUI"
src_trigger_dir = base_dir / "src" / "triggers" / "DGRGUI" / "EMCOCHAT"

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


def add_trigger(parent, name, script_text, regex, is_active="yes"):
    trigger_elem = ET.SubElement(parent, "Trigger", isActive=is_active, isFolder="no")
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

# ScriptPackage (flat, no folders)
script_package = ET.SubElement(root, "ScriptPackage")

parent_readme = src_script_dir_gui / "README.lua"
if parent_readme.exists():
    add_script(script_package, "README", parent_readme.read_text(encoding="utf-8"))

parent_scripts_json_path = src_script_dir_gui / "scripts.json"
if parent_scripts_json_path.exists():
    parent_scripts_json = json.loads(parent_scripts_json_path.read_text(encoding="utf-8"))
    for entry in parent_scripts_json:
        name = entry.get("name")
        if not name or name == "README":
            continue
        script_path = src_script_dir_gui / f"{name}.lua"
        if script_path.exists():
            add_script(script_package, name, script_path.read_text(encoding="utf-8"))

emco_readme = src_script_dir_emco / "README.lua"
if emco_readme.exists():
    add_script(script_package, "EMCO_README", emco_readme.read_text(encoding="utf-8"))

code_script = (src_script_dir_emco / "Code.lua").read_text(encoding="utf-8")
add_script(script_package, "Code", code_script.replace("@PKGNAME@", pkg_name))

scripts_json_path = src_script_dir_emco / "scripts.json"
if scripts_json_path.exists():
    scripts_json = json.loads(scripts_json_path.read_text(encoding="utf-8"))
    for entry in scripts_json:
        name = entry.get("name")
        if name and name != "Code":
            script_path = src_script_dir_emco / f"{name}.lua"
            if script_path.exists():
                add_script(script_package, name, script_path.read_text(encoding="utf-8"))

# AliasPackage (flat, no folders)
alias_package = ET.SubElement(root, "AliasPackage")

parent_alias_readme = src_gui_alias_dir / "README.lua"
if parent_alias_readme.exists():
    add_alias(alias_package, "README", parent_alias_readme.read_text(encoding="utf-8"), "^__DGRGUI_README__$")

parent_aliases_json_path = src_gui_alias_dir / "aliases.json"
if parent_aliases_json_path.exists():
    parent_aliases_json = json.loads(parent_aliases_json_path.read_text(encoding="utf-8"))
    for alias_def in parent_aliases_json:
        name = alias_def["name"]
        regex = alias_def["regex"]
        filename = name.replace(" ", "_") + ".lua"
        script_path = src_gui_alias_dir / filename
        if not script_path.exists():
            raise SystemExit(f"Missing alias source file: {script_path}")
        script_content = script_path.read_text(encoding="utf-8").replace("@PKGNAME@", pkg_name)
        add_alias(alias_package, name, script_content, regex)

for alias_def in aliases_json:
    name = alias_def["name"]
    regex = alias_def["regex"]
    filename = name.replace(" ", "_") + ".lua"
    script_path = src_alias_dir / filename
    if not script_path.exists():
        raise SystemExit(f"Missing alias source file: {script_path}")
    script_content = script_path.read_text(encoding="utf-8").replace("@PKGNAME@", pkg_name)
    add_alias(alias_package, name, script_content, regex)

# TriggerPackage (flat, no folders)
trigger_package = ET.SubElement(root, "TriggerPackage")

parent_trigger_readme = base_dir / "src" / "triggers" / "DGRGUI" / "README.lua"
if parent_trigger_readme.exists():
    add_trigger(trigger_package, "README", parent_trigger_readme.read_text(encoding="utf-8"), "^__DGRGUI_TRIGGERS_README__$")

emco_trigger_readme = src_trigger_dir / "README.lua"
if emco_trigger_readme.exists():
    add_trigger(trigger_package, "EMCO_TRIGGERS_README", emco_trigger_readme.read_text(encoding="utf-8"), "^__DGRGUI_EMCO_TRIGGERS_README__$")

triggers_json_path = src_trigger_dir / "triggers.json"
if triggers_json_path.exists():
    triggers_json = json.loads(triggers_json_path.read_text(encoding="utf-8"))
    for entry in triggers_json:
        name = entry.get("name")
        regex = entry.get("regex")
        if not name or not regex:
            continue
        trigger_path = src_trigger_dir / f"{name}.lua"
        if not trigger_path.exists():
            raise SystemExit(f"Missing trigger source file: {trigger_path}")
        trigger_content = trigger_path.read_text(encoding="utf-8")
        add_trigger(trigger_package, name, trigger_content, regex, is_active="no")

xml_declaration = "<?xml version='1.0' encoding='utf-8'?>\n"
xml_body = ET.tostring(root, encoding="unicode")
xml_path.write_text(xml_declaration + xml_body, encoding="utf-8")

print("Updated build_manual/DGRGUI.xml from src (flat)")
