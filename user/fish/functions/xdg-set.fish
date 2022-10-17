function xdg-set
  set filename (f)
  if test "$filename" = ""
  else 
    set beforeprogram (xdg-mime query default (xdg-mime query filetype $filename))
    set program (find /usr/share/applications/ -type f | f) 
    if test "$program" = ""
    else
      echo "Open with $beforeprogram before changing"
      xdg-mime default (echo $program | sed 's/.*\///g') (xdg-mime query filetype $filename)
      set afterprogram (xdg-mime query default (xdg-mime query filetype $filename))
      echo "Open with $afterprogram after change"
    end
  end
end
