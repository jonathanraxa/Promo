# Promo
Promo text replacer script

SINGLEFILE.RB (McAfee Pages)
- These pages are structured in a such a way as to enable us to capture specific values from the page in order for us to change them.

HOW TO USE

1) Place the script in a directory containing the files that you want to modify

2) Ensure that the command prompt is prompted in the directory in which you are modifiying the file. You can do this by:
- Hold "Shift" then "Right-Click" on the DIRECTORY that your files and your script is in
- A pop up will open and you should select "Open command window here"

3) To execute the script, type: "ruby singleFile.rb [insert the file name here (no need to use '.html' at the end)]"

4) Type in your desired values for each element

5) If you need to QUIT abruptly or you made a mistake, hit 'ctrl+c' which will remove you from the session without saving any changes

____________________________________________________________________


DIRECTORY.RB
- Replaces all instances of a word/text across all files within a directory

1) Place the script one level above the directory to be modified

2) Run the script within the command line with "ruby directory.rb /[directory name here]"

3) The script will prompt you with what you WANT to replace, then with what you want to replace it with
