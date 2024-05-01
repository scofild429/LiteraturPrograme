for i in *.org;
do
    pandoc -s $i -o ./library/src/$i.md;
done

cd library/
mdbook build
xdg-open book/index.html
