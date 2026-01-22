#!/usr/bin/env python3
import json
import os
import shutil
import xml.etree.ElementTree as ET
from pathlib import Path
import zipfile

base_dir = Path(__file__).resolve().parent
src_dir = base_dir / "src"
build_dir = base_dir / "build_manual"

mfile = json.loads((base_dir / "mfile").read_text(encoding="utf-8"))
pkg_name = mfile["package"]
version = mfile["version"]

# Prepare build directory
if build_dir.exists():
    shutil.rmtree(build_dir)
build_dir.mkdir(parents=True)
(build_dir / ".mudlet" / "Icon").mkdir(parents=True)

# Copy resources to build root
resources = src_dir / "resources"
for item in resources.iterdir():
    if item.is_file():
        shutil.copy2(item, build_dir / item.name)

# Copy icon
icon_path = resources / "computer.png"
if icon_path.exists():
    shutil.copy2(icon_path, build_dir / ".mudlet" / "Icon" / "computer.png")

# Build XML
root = ET.Element("MudletPackage", version="1.001")

# ScriptPackage
script_package = ET.SubElement(root, "ScriptPackage")
script_group = ET.SubElement(script_package, "ScriptGroup", isActive="yes", isFolder="yes")
ET.SubElement(script_group, "name").text = pkg_name
ET.SubElement(script_group, "script")
ET.SubElement(script_group, "packageName").text = pkg_name
ET.SubElement(script_group, "eventHandlerList")

scripts_dir = src_dir / "scripts" / pkg_name
if scripts_dir.exists():
    for script_path in sorted(scripts_dir.glob("*.lua")):
        script = ET.SubElement(script_group, "Script", isActive="yes", isFolder="no")
        ET.SubElement(script, "name").text = script_path.stem
        ET.SubElement(script, "script").text = script_path.read_text(encoding="utf-8")
        ET.SubElement(script, "command")
        ET.SubElement(script, "packageName").text = pkg_name
        ET.SubElement(script, "eventHandlerList")

# AliasPackage
alias_package = ET.SubElement(root, "AliasPackage")
alias_group = ET.SubElement(alias_package, "AliasGroup", isActive="yes", isFolder="yes")
ET.SubElement(alias_group, "name").text = pkg_name
ET.SubElement(alias_group, "script")
ET.SubElement(alias_group, "packageName").text = pkg_name

aliases_dir = src_dir / "aliases" / pkg_name
aliases_json = json.loads((aliases_dir / "aliases.json").read_text(encoding="utf-8"))
for alias_def in aliases_json:
    name = alias_def["name"]
    regex = alias_def["regex"]
    script_path = aliases_dir / (name.replace(" ", "_") + ".lua")
    script_text = script_path.read_text(encoding="utf-8").replace("@PKGNAME@", pkg_name)

    alias = ET.SubElement(alias_group, "Alias", isActive="yes", isFolder="no")
    ET.SubElement(alias, "name").text = name
    ET.SubElement(alias, "script").text = script_text
    ET.SubElement(alias, "command")
    ET.SubElement(alias, "packageName").text = pkg_name
    ET.SubElement(alias, "regex").text = regex

# TriggerPackage (empty group)
trigger_package = ET.SubElement(root, "TriggerPackage")
trigger_group = ET.SubElement(trigger_package, "TriggerGroup", isActive="yes", isFolder="yes")
ET.SubElement(trigger_group, "name").text = pkg_name
ET.SubElement(trigger_group, "script")
ET.SubElement(trigger_group, "packageName")

# Write XML
xml_path = build_dir / f"{pkg_name}.xml"
xml_declaration = "<?xml version='1.0' encoding='utf-8'?>\n"
xml_body = ET.tostring(root, encoding="unicode")
xml_path.write_text(xml_declaration + xml_body, encoding="utf-8")

# Create package
package_path = base_dir / f"{pkg_name}.mpackage"
if package_path.exists():
    package_path.unlink()

with zipfile.ZipFile(package_path, "w", zipfile.ZIP_DEFLATED) as zf:
    for root_dir, _, files in os.walk(build_dir):
        for filename in files:
            file_path = Path(root_dir) / filename
            arcname = file_path.relative_to(build_dir)
            zf.write(file_path, arcname)

print(f"Built {package_path}")
