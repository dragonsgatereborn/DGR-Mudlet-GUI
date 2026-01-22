#!/usr/bin/env python3
import json
import xml.etree.ElementTree as ET
from pathlib import Path

base_dir = Path(__file__).resolve().parent
xml_path = base_dir / "build_manual" / "EMCOChat.xml"

pkg_name = "EMCOChat"

src_alias_dir = base_dir / "src" / "aliases" / "EMCO"
src_script_dir = base_dir / "src" / "scripts" / "EMCO"

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


root = ET.Element("MudletPackage", version="1.001")

# ScriptPackage
script_package = ET.SubElement(root, "ScriptPackage")
script_group = ET.SubElement(script_package, "ScriptGroup", isActive="yes", isFolder="yes")
add_text(script_group, "name", "EMCO")
add_text(script_group, "script")
add_text(script_group, "packageName", pkg_name)
add_text(script_group, "eventHandlerList")

code_script = (src_script_dir / "Code.lua").read_text(encoding="utf-8")
add_script(script_group, "Code", code_script.replace("@PKGNAME@", pkg_name))

# AliasPackage
alias_package = ET.SubElement(root, "AliasPackage")
alias_group = ET.SubElement(alias_package, "AliasGroup", isActive="yes", isFolder="yes")
add_text(alias_group, "name", "EMCO")
add_text(alias_group, "script")
add_text(alias_group, "packageName", pkg_name)

for alias_def in aliases_json:
    name = alias_def["name"]
    regex = alias_def["regex"]
    filename = name.replace(" ", "_") + ".lua"
    script_path = src_alias_dir / filename
    if not script_path.exists():
        raise SystemExit(f"Missing alias source file: {script_path}")
    script_content = script_path.read_text(encoding="utf-8").replace("@PKGNAME@", pkg_name)
    add_alias(alias_group, name, script_content, regex)

xml_declaration = "<?xml version='1.0' encoding='utf-8'?>\n"
xml_body = ET.tostring(root, encoding="unicode")
xml_path.write_text(xml_declaration + xml_body, encoding="utf-8")

print("Updated build_manual/EMCOChat.xml from src")
