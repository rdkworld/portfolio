## Commands

1. curl -c ./cookie -s -L "https://drive.google.com/uc?export=download&id=$11hg55-dKdHN63yJP20dMLAgPJ5oiTOHF" > /dev/null | curl -Lb ./cookie "https://drive.google.com/uc?export=download&confirm=`awk '/download/ {print $NF}' ./cookie`&id=11hg55-dKdHN63yJP20dMLAgPJ5oiTOHF" -o images.zip && sudo rm -rf cookie
# download images
2. unzip <zip file> #unzip images
3. pip3 install <package>
4. chmod +x <script_name>.py #make the script executable
5. ./<scriptname> #run the script
#Test
python3 \n
img = Image.open("/opt/icons/ic_edit_location_black_48dp")
img.format, img.size



