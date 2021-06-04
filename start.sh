#/bin/bash

if [[ $(ls | grep result) == "result" ]]
then
rm result
fi
export PATH=$PATH:$(pwd)/bin
python3 main.py > log
cat log |  sed -n '/Понедельник/,/Суббота/p' > foo
cat foo | sed -r '/^\s*$/d' | tr -d "\\\\" | grep -v ..:.....:.. | tr -d "_" | grep -v "Суббота" > bar
wc=$(cat bar | wc -l)
touch a
for ((i="1"; i <= "$wc";i++))
do
    wcc=$(cat bar | head -"$i" | tail -1 | grep -o "." | wc -l) 
    if [ "$wcc" -gt "2" ]
    then
        a=$(cat a)
        if [ "$a" == "1" ]
        then
            stringg=$(cat bar | head -"$i" | tail -1)
            y=$(( "$i" - "1" ))
            string=$(cat bar | head -"$y" | tail -1)
            stringgg="$string"" ""$stringg"
            echo >> result
            echo $stringgg >> result
            echo 0 > a
        else 
            s=$(cat bar | head -"$i" | tail -1 | grep -o 'Понедельник\|Вторник\|Среда\|Четверг\|Пятница')
            if [[ -n "$s" ]] 
            then
                if [[ "$s" == "Понедельник" ]]
                then
                    echo "--------------------------------------------------------------" >> result
                    cat bar | head -"$i" | tail -1 >> result
                    echo "--------------------------------------------------------------" >> result
                else
                    echo >> result
                    echo "--------------------------------------------------------------" >> result
                    cat bar | head -"$i" | tail -1 >> result
                    echo "--------------------------------------------------------------" >> result
                fi
            else
                cat bar | head -"$i" | tail -1 >> result
            fi
        fi
    else 
        echo 1 > a
    fi
done

rm a bar foo log geckodriver.log
