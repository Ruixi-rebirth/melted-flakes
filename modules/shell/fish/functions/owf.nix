''
  function owf
    set path (f)
    if test "$path" = ""
      else if [ "$path" != "" ] 
        if test -d $path
         $path 
        else
        xdg-open $path 
      end
    end
  end
''
