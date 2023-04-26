library(GEOquery)
library(GEOquery)
BiocManager::install("copa")
gds=getGEO("GDS6100")
eset=GDS2eSet(gds,do.log2 = TRUE)
veri=t(exprs(eset))
veri[1:5,1:5]
durum=pData(eset)$diseae.state #özniteliği değerler çıkarılır.
library(randomForest)
set.seed(1)
aykırı=randomForest(veri,durum, proximity = TRUE)
#Bu uzaklıkları içeren model kullanılarak aşağıdaki outlier() fonksiyonu şke aykırı değerler elde edilir.
#Biz bu aykırı değerler içinden en önemlisinden başlamak üzere sırayla beş tanesini seçiyoruz
order(outlier(aykırı),decreasing = TRUE)[1:5]
#COPA aykırı Değer analizi uygulanması
library(copa) #BiocManager::install("copa")
#ilk iki sütun ekrana bastırılır.
pData(eset)[,1:2]
c1=abs(3-as.numeric(pData(eset)[,2]))
c1
#Gen çiftlerini bulabilmek için copa() fonksiyonu kullanılacak
#Burada, c1 expression ifadesi içeren vektördür, Diğer pct değeri ise
#verinin ön filtrelenmesi için kullanılan bir yüzde değeridir. Varsayılan değer %95
#olarak kabul edilir. Daha az sayıda aykırı değer içeren tüm genler değerlendirmeden

#çıkartılır.
sonuc=copa(eset,c1,pct=0.99)
tableCopa(sonuc)
summaryCopa(sonuc,7)
