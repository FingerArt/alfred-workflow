query=$1

function printItem() {
    _obase=$1
    _value=$2
    decimal=$(($_value))
    result=`echo "obase=$_obase;$decimal" | bc`
    case $_obase in
        2)
            type="Binary"
        ;;
        8)
            type="Octal"
            if [ $result -ne 0 ];then
                result="0$result"
            fi
        ;;
        16) type="HEX"
            result="0x$result"
        ;;
        10)
            type="Decimala"
        ;;
    esac
    cat << EOB
        <item uid="${type}" arg="${result}">
            <title>${result}</title>
            <subtitle>${type}</subtitle>
            <icon>icon.png</icon>
        </item>
EOB
}

cat << EOB
<?xml version="1.0"?>
    <items>
EOB

printItem 2 $query
printItem 8 $query
printItem 10 $query
printItem 16 $query

cat << EOB
</items>
EOB