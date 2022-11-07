''
  function xdg-set
    set applicationsdir (echo $XDG_DATA_DIRS | sed 's/:/\/applications\/\n/g; s/$/&\/applications\//g')
    set arr2
    for arr1 in $applicationsdir
      if test -d $arr1
        set -a arr2 $arr1
      end
    end 
    set filename (f)
    if test "$filename" = ""
    else 
      set beforeprogram (xdg-mime query default (xdg-mime query filetype $filename))
      set program (find $arr2 -type l | f) 
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
