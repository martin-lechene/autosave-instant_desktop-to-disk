import shutil
import os
from datetime import datetime, timedelta

# Chemin source
src_folder = "C:\\Users\\mlechene\\Code"

# Chemin de destination
today = datetime.now().strftime("%Y-%m-%d")
time = datetime.now().strftime("%H")
dest_folder = f"E:\\instant\\instant_{today}-{time}H"
if not os.path.exists(dest_folder):
    os.makedirs(dest_folder)

# Copier les fichiers et dossiers du répertoire source vers le répertoire destination
shutil.copytree(src_folder, dest_folder)

# Déplacer les anciens fichiers vers le répertoire "instant_old"
one_month_ago = datetime.now() - timedelta(days=30)
for foldername, subfolders, filenames in os.walk(dest_folder):
    for subfolder in subfolders:
        folder_path = os.path.join(foldername, subfolder)
        folder_time = datetime.fromtimestamp(os.path.getmtime(folder_path))
        if folder_time < one_month_ago:
            old_folder = os.path.join("E:\\instant\\instant_old", subfolder)
            shutil.move(folder_path, old_folder)
