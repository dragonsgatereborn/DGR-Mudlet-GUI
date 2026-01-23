#!/usr/bin/env python3
import os
import zipfile
from pathlib import Path

base_dir = Path(__file__).resolve().parent
build_dir = base_dir / "build_bg"
output_file = base_dir / "DGRGUI_BG.mpackage"

print("Building DGRGUI_BG.mpackage from build_bg...")
if output_file.exists():
    output_file.unlink()

with zipfile.ZipFile(output_file, 'w', zipfile.ZIP_DEFLATED) as zipf:
    for root, dirs, files in os.walk(build_dir):
        for file in files:
            file_path = Path(root) / file
            arcname = file_path.relative_to(build_dir)
            zipf.write(file_path, arcname)
            print(f"  Added {arcname}")

print(f"\n✓ Package built successfully: {output_file}")
print(f"  Size: {output_file.stat().st_size:,} bytes")
