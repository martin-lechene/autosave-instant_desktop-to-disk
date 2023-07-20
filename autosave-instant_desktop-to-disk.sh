#!/bin/bash

# Chemin source
src_folder="/c/Users/mlechene/Code"

# Chemin de destination
today=$(date +"%Y-%m-%d")
time=$(date +"%H")
dest_folder="/e/instant/instant_${today}-${time}H"
mkdir -p "${dest_folder}"

# Copier les fichiers et dossiers du répertoire source vers le répertoire destination
cp -R "${src_folder}" "${dest_folder}"

# Déplacer les anciens fichiers vers le répertoire "instant_old"
one_month_ago=$(date --date='-30 days' +"%s")
find "${dest_folder}" -type d -mtime +30 -print0 | while read -d '' -r folder_path
do
    folder_time=$(stat -c '%Y' "${folder_path}")
    if [ "${folder_time}" -lt "${one_month_ago}" ]
    then
        old_folder="/e/instant/instant_old/$(basename ${folder_path})"
        mv "${folder_path}" "${old_folder}"
    fi
done
