''
  function xdg-get
    set filename (f)
      if test "$filename" = ""
    else 
      set program (xdg-mime query default (xdg-mime query filetype $filename))
      echo "Open with $program"
    end
  end
''
