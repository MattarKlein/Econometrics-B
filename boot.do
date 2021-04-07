//ssc install estout
//ssc install markstat
//ssc install whereis
//ssc install bundle
whereis pandoc "C:\Program Files\Pandoc\pandoc.exe" //need to install pandoc and show stata where it is
whereis pdflatex "C:\Program Files\MikTeX\miktex\bin\x64\pdflatex.exe" //need to install a latex to pdf converter like miktex and show stata where it is
//This is the do file for quickly creating htmls
cd "C:\Users\MSKle\Desktop\Econometrics-B"
markstat using PS2, pdf //replace this with file needed
//bundle using PS2 //This is used when there are images in html