#!/bin/bash

function tablo_sil() {

	if [ -a $1 ]
	then
		echo "tablo var ve tablonuz siliniyor..."
	else
		echo "tablo yok."
	fi
	rm -rf $1
	echo "$1 tablosu silindi." 	

}

function kayit_ekle() {

	echo "yeni kayit bilgilerini gir :"
	read yeni
	echo $yeni >>$1
	echo ""
	cat $1

}

function kayit_sil() {
	
	echo "hangi kaydi silmek istiyorsun satir sayisi  gir :"
	read row
	echo $row>tmp.txt
	#cat tmp.txt
	echo ""
	i=0
	row1=`cut -d: -f1 tmp.txt`
	row2=`cut -d: -f2 tmp.txt`
	#echo $row1
	#echo $row2
	echo ""
	while read line
	do
		i=$(($i+1))
		if [ $i -eq $row1 -o $i -eq $row2 ]
		then
			echo $line "bilgileri silinecek."
			rm -rf $line
			echo "bilgiler silindi."
		fi	
	done<$1
	echo ""
	#cat $1
	
}

function tablo_sirala(){

	echo "alfabetik siralama için 'a' nümerik siralamala için 'b' ye basin :"
	read secenek

	case $secenek in
		a) cat | sort $1
			;;
		b) cat | sort -n  $1
			;;
		*) echo "yanlis parametre girdin."
			;;
	esac		
	
}

echo "islem yapacagin tablonun ismini gir :"
read tablo
if [ -a $tablo ]
then
	echo "$tablo var ve islemler bu tablo üzerinden yapilacak..."
else
	echo "$tablo yok ve yeni bir tablo olusturmak icin 'e' tusuna basiniz :"
	read ch
	case $ch in
		e) echo "yeni tablonun ismini giriniz.";read tablo;
			touch $tablo;
			echo "yeni tablonuz basarili bir sekilde olusturuldu...";;
		*) echo "yanlis karakter secimi yaptiniz.";;	
	esac
fi
	
while [ $sec=5 ]
do
	echo "PROGRAM MENU"
	echo ""
	echo "1. TABLOYU SIL"
	echo ""
	echo "2. KAYIT EKLE"
	echo ""
	echo "3. KAYIT SIL"
	echo ""
	echo "4. TABLOYU SIRALA"
	echo ""
	echo "5. PROGRAMI KAPAT"
	echo ""
	echo -n "Seciminizi Giriniz:"
	read sec
	
	case $sec in
		1)tablo_sil $tablo
			;;
		2)kayit_ekle $tablo
			;;
		3)kayit_sil $tablo
			;;
		4)tablo_sirala $tablo
			;;
		5)exit
			;;
		*)echo "Yanlis seçim yaptiniz.Tekrar deneyin..."
			;;
	esac
done
