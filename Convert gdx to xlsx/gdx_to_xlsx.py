import os
import sys
import argparse
import pandas as pd
import gams.transfer as gt

GAMS_SYS_DIR = "/Library/Frameworks/GAMS.framework/Versions/54/Resources"


def convert_gdx_to_xlsx(input_file, output_file):
    if not os.path.exists(input_file):
        print(f"Error: The file '{input_file}' was not found.")
        sys.exit(1)

    if not input_file.lower().endswith(".gdx"):
        print("Warning: The input file does not have a .gdx extension. Attempting to process anyway...")

    try:
        print(f"Opening {input_file}...")
        m = gt.Container(input_file, system_directory=GAMS_SYS_DIR)

        if not m.data:
            print("The GDX file is empty. No symbols found to export.")
            return

        with pd.ExcelWriter(output_file, engine="xlsxwriter") as writer:
            for symbol_name, symbol_obj in m.data.items():
                df = symbol_obj.records

                if df is None or df.empty:
                    df = pd.DataFrame()

                sheet_name = symbol_name[:31]
                df.to_excel(writer, sheet_name=sheet_name, index=False)
                print(f"  Exported symbol: {symbol_name}")

        print(f"\nSuccess! File saved as: {output_file}")

    except Exception as e:
        print(f"An unexpected error occurred: {e}")
        sys.exit(1)


if __name__ == "__main__":
    parser = argparse.ArgumentParser(
        description="Universal converter for GAMS .gdx files to Excel .xlsx files."
    )
    parser.add_argument("input", help="Path to the source .gdx file")
    parser.add_argument("output", help="Path/name for the resulting .xlsx file")

    args = parser.parse_args()
    convert_gdx_to_xlsx(args.input, args.output)