''
  function xdg-set
    set applicationsdir (echo $XDG_DATA_DIRS | sed 's/:/\/applications\/\ /g;s/$/&\/applications\//g')
    set filename (f)
    if test "$filename" = ""
    else 
      set beforeprogram (xdg-mime query default (xdg-mime query filetype $filename))
      set program (find /etc/profiles/per-user/ruixi/share/applications/ -type l | f) 
      if test "$program" = ""
      else
        echo "Open with $beforeprogram before changing"
        xdg-mime default (echo $program | sed 's/.*\///g') (xdg-mime query filetype $filename)
        set afterprogram (xdg-mime query default (xdg-mime query filetype $filename))
        echo "Open with $afterprogram after change"
      end
    end
  end
''
