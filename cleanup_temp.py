import os

TEMP_DIR = "/tmp/test_temp"

print("Executing cleanup")
if os.path.exists(TEMP_DIR):
    for filename in os.listdir(TEMP_DIR):
        file_path = os.path.join(TEMP_DIR, filename)
        if os.path.isfile(file_path):
            os.remove(file_path)
