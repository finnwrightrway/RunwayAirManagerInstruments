import os
import xml.etree.ElementTree as ET

def find_xml_files(folder):
    xml_files = []
    for root, _, files in os.walk(folder):
        for file in files:
            if file.endswith(".xml"):
                xml_files.append(os.path.join(root, file))
    return xml_files

def parse_xml_for_tags(xml_file):
    tree = ET.parse(xml_file)
    root = tree.getroot()
    aircraft_tag = root.find('aircraft')
    type_tag = root.find('type')
    
    aircraft = aircraft_tag.text if aircraft_tag is not None else None
    type_ = type_tag.text if type_tag is not None else None
    
    return aircraft, type_

def rename_folders(base_folder):
    for root_folder in next(os.walk(base_folder))[1]:
        folder_path = os.path.join(base_folder, root_folder)
        xml_files = find_xml_files(folder_path)
        
        if not xml_files:
            print(f"No XML files found in folder: {folder_path}")
            continue
        
        for xml_file in xml_files:
            aircraft, type_ = parse_xml_for_tags(xml_file)
            
            if aircraft and type_:
                new_folder_name = f"{aircraft}_{type_}"
                new_folder_path = os.path.join(base_folder, new_folder_name)
                if not os.path.exists(new_folder_path):
                    os.rename(folder_path, new_folder_path)
                    print(f"Renamed folder {folder_path} to {new_folder_path}")
                else:
                    print(f"Folder {new_folder_path} already exists. Skipping rename.")
                break

if __name__ == "__main__":
    base_folder = os.getcwd()
    rename_folders(base_folder)
