on open location magnetURL
    do shell script "~/downloadMagnet.sh \"" & magnetURL & "\" > ~/test 2>&1 &"
    display notification "Download: " & magnetURL
end open location
      