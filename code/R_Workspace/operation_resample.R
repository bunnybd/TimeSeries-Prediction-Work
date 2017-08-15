
#�洢ʱ������-------------------------------------------------------------------------------------------
#����
function(){
  t<-read.csv("F:\\sql_out\\20161026-���ͳ���ʱ��GroupTop100\\163_0151_2016-06-30_80.csv", header = TRUE)
  
  btsj_tmp<-as.POSIXlt(t[,6])
  btsj<-btsj_tmp[1:5]
  
  # list<-list()
  # k<-1
  # for(i in 2:length(btsj)){
  #   if(btsj[i-1]-btsj[i]==0){
  #     list[k]<-btsj[i]
  #     k<-k+1
  #   }
  # }
  
  axle1_p1<-data.163.0151.0630.allAxisTemp.merge[1:5,1]
  axle1_p2<-data.163.0151.0630.allAxisTemp.merge[1:5,2]
  z1<-zoo(x=axle1_p1, order.by = btsj)
  z2<-zoo(x=axle1_p2, order.by = btsj)
  btsj.z<-merge(z1,z2)
  #btsj.z<-cbind(z1,z2,z3)
}
#�¶������ز���-------------------------------------------------------------------------------------------
#��ʵ����
function(){
  t<-read.csv("F:\\sql_out\\20161026-���ͳ���ʱ��GroupTop100\\out\\allaxistemperature_merge2\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1.csv", header = TRUE)
  
  #install.packages("zoo")
  library("zoo")
  #ʱ����49��
  rowsLen<-1:nrow(t)
  btsj<-as.POSIXlt(t[rowsLen,49])
  #1~48Ϊ��ֵ��¶�����
  data<-t[rowsLen,1:48]
  data[,49:68]<-t[rowsLen,50:69]
  
  z<-zoo(x=data, order.by = btsj)
  
  #�ز���
  library("dtwSat")
  ts<-twdtwTimeSeries(z)#�ǵ������ʱ�����л��洢��
  #dim(ts)#û�н�ʱ����һ������col
  resample_ts<-resampleTimeSeries(ts, length = 6)
  #snrow(resample_ts[[1]])
  
  plot(resample_ts[[1]][,2], type="o")
  lines(z[,2], col=c("red"), type="o")
  
  #write.table()
  
  resample_ts[[1]][1:20,1:3]
  z[1:20,1:3]
  
}

#����matlab�ز����Ľ��������-Working
function(){
  
  #---------------------------------------------------------
  #��������
  data.ori<-read.csv("F:\\sql_out\\20161026-���ͳ���ʱ��GroupTop100\\out\\allaxistemperature_merge2\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1.csv", header = TRUE)
  data.reg<-read.csv("F:\\sql_out\\20161026-���ͳ���ʱ��GroupTop100\\out\\allaxistemperature_merge2\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv", header = TRUE)

  #�����ݱ��ʱ������
  
  
  data.ori.btsj<-as.POSIXlt(data.ori[,49])
  data.ori.attr<-data.ori[,1:48]
  data.ori.attr[,49:68]<-data.ori[,50:69]
  data.ori.z<-zoo(x=data.ori.attr, order.by = data.ori.btsj)
  
  data.reg.btsj<-as.POSIXlt(data.reg[,1])
  data.reg.attr<-data.reg[,2:69]
  m = nrow(data.reg.attr)
  n = ncol(data.reg.attr)
  # for(i in 1:m){
  #   for(j in 1:n){
  #     data.reg.attr[i,j]<-as.numeric(data.reg.attr[i,j])
  #   }
  # }
  data.reg.z<-zoo(x=data.reg.attr, order.by = data.reg.btsj)
  
  ##plot�������
  #plot(data.ori.z[,1], type="o")
  #lines(data.reg.z[,1], col=c("red"), type="o")
  
  #----------------------------------------------------------
  #���ز��������������������浽txt������autopait��������״̬
  #�����һ��һλ����
  data.reg.out.com<-data.reg.attr[,52:56]
  data.reg.out.axle<-data.reg.attr[,1:6]
  data.reg.out.hw<-data.reg.attr[,57:58]
  data.reg.out<-data.reg.out.axle
  data.reg.out[,7:8]<-data.reg.out.hw
  data.reg.out[,9:13]<-data.reg.out.com
  #�����txt
  write.table(data.reg.out, "163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg_axl1.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
}
#����matlab�ز����Ľ��������-Working
function(){
  #---------------------------------------------------------
  #��������
  # data.ori<-read.csv("F:\\sql_out\\20161103-�������±���_1��_axleTempFault\\out\\remove duplication\\231_6092_2016-04-06_axleTempFault_14_merge2_1.csv", header = TRUE)
  # data.reg<-read.csv("F:\\sql_out\\20161103-�������±���_1��_axleTempFault\\out\\resample\\231_6092_2016-04-06_axleTempFault_14_merge2_1_ri_10.csv", header = TRUE)
  data.ori<-read.csv(filelist[1], header = TRUE)
  data.reg<-read.csv(filelist[2], header = TRUE)
  #�����ݱ��ʱ������
  library("zoo")
  data.ori.btsj<-as.POSIXlt(data.ori[,49])
  data.ori.attr<-data.ori[,1:48]
  data.ori.attr[,49:68]<-data.ori[,50:69]
  data.ori.z<-zoo(x=data.ori.attr, order.by = data.ori.btsj)
  
  data.reg.btsj<-as.POSIXlt(data.reg[,1])
  data.reg.attr<-data.reg[,2:69]
  m = nrow(data.reg.attr)
  n = ncol(data.reg.attr)
  # for(i in 1:m){
  #   for(j in 1:n){
  #     data.reg.attr[i,j]<-as.numeric(data.reg.attr[i,j])
  #   }
  # }
  data.reg.z<-zoo(x=data.reg.attr, order.by = data.reg.btsj)
  
  #plot�������
  plot(data.ori.z[,1], type="o")
  lines(data.reg.z[,1], col=c("red"), type="o")
  
  #----------------------------------------------------------
  #���ز��������������������浽txt������autopait��������״̬
  #�����һ��һλ����
  data.reg.out.com<-data.reg.attr[,52:56]
  data.reg.out.axle<-data.reg.attr[,1:6]
  data.reg.out.hw<-data.reg.attr[,57:58]
  data.reg.out<-data.reg.out.axle
  data.reg.out[,7:8]<-data.reg.out.hw
  data.reg.out[,9:13]<-data.reg.out.com
  #�����txt
  write.table(data.reg.out, "163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg_axl1.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
}
#���ز��������������������浽txt������autopait��������״̬
function(){
  
  #data.reg<-read.csv("C:\\Users\\YangDi\\Documents\\MATLAB\\163_0151_2016-07-11_85_allAxisTemperature_merge2_1_reg.csv", header = TRUE)
  #data.reg<-read.csv("C:\\Users\\YangDi\\Documents\\MATLAB\\163_0158_2016-08-10_84_allAxisTemperature_merge2_1_reg.csv", header = TRUE)
  data.reg<-read.csv("F:\\sql_out\\20161103-�������±���_1��_axleTempFault\\out\\resample\\231_6092_2016-04-06_axleTempFault_14_merge2_1_ri_10.csv", header = TRUE)
  
  data.reg.attr<-data.reg[,2:69]
  
  #�����һ��һλ����
  data.reg.out.com<-data.reg.attr[,52:56]
  data.reg.out.axle<-data.reg.attr[,1:6]
  data.reg.out.hw<-data.reg.attr[,57:58]
  data.reg.out<-data.reg.out.axle
  data.reg.out[,7:8]<-data.reg.out.hw
  data.reg.out[,9:13]<-data.reg.out.com
  #�����txt
  write.table(data.reg.out, "F:\\sql_out\\20161103-�������±���_1��_axleTempFault\\out\\resample\\231_6092_2016-04-06_axleTempFault_14_merge2_1_ri_10_axle1.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
  #write.table(data.reg.out, "C:\\Users\\YangDi\\Documents\\MATLAB\\163_0151_2016-07-11_85_allAxisTemperature_merge2_1_reg_axl1.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
  #write.table(data.reg.out, "C:\\Users\\YangDi\\Documents\\MATLAB\\163_0158_2016-08-10_84_allAxisTemperature_merge2_1_reg_axl1.txt", row.names = FALSE, col.names = FALSE, quote = FALSE)
}
#��ȡ�ļ������ļ�
function(){
  #dirname = "F:\\sql_out\\20161103-�������±���_1��_axleTempFault\\out\\5.resample";
  #dirname = "F:\\sql_out\\20161103-�������±���_1��_axleTempFault\\out\\4.remove duplication\\used to HMM"
  #dirname = "F:\\sql_out\\20161103-�������±���_1��_axleTempFault\\out\\5.resample\\�ڶ���"
  dirname = "F:\\sql_out\\20161103-�������±���_1��_axleTempFault\\out\\4.remove duplication\\used to HMM\\�ڶ���-��ѡ������������ļ���״̬"
  dir = list.files(dirname)
  filelist = paste(dirname,"\\",sep="")
  filelist = paste(filelist,dir,sep="")
  
  for(i in 1:length(filelist)){
    data.reg<-read.csv(filelist[i], header = TRUE)
    data.reg.attr<-data.reg[,2:69]
    
    #�����һ��һλ����
    data.reg.out.com<-data.reg.attr[,52:56]
    data.reg.out.axle<-data.reg.attr[,1:6]
    data.reg.out.hw<-data.reg.attr[,57:58]
    data.reg.out<-data.reg.out.axle
    data.reg.out[,7:8]<-data.reg.out.hw
    data.reg.out[,9:13]<-data.reg.out.com
    #�����txt
    filename.out = substr(filelist[i], 1, nchar(filelist[i])-4)
    filename.out = paste(filename.out,".txt")
    write.table(data.reg.out, filename.out, row.names = FALSE, col.names = FALSE, quote = FALSE)
  }
  
}
#�Է�״̬���ݵ�ÿ��״̬����VAR����
#Ŀǰֻ����
#163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg_axl1.txt
setwd("E:\\R_Workspace")
source("operation_resample.R")
source("VAR_Data_Analysis2.R")
reample.var.test<-function(){
  
  data.reg<-read.csv("C:\\Users\\YangDi\\Documents\\MATLAB\\163_0151_2016-06-30_80_allAxisTemperature_merge2_1_reg.csv", header = TRUE)
  data.reg.attr<-data.reg[,2:69]
  
  #�����һ��һλ����
  data.reg.out.com<-data.reg.attr[,52:56]
  data.reg.out.axle<-data.reg.attr[,1:6]
  data.reg.out.hw<-data.reg.attr[,57:58]
  data.reg.out<-data.reg.out.axle
  data.reg.out[,7:8]<-data.reg.out.hw
  data.reg.out[,9:13]<-data.reg.out.com
  
  #�õ��ֶ�����
  data.reg.analyze<-data.reg.out
  
  ses<-list(NULL)
  ses[[1]]<-c(5873+1,6971+1)
  ses[[2]]<-c(5359+1,5872+1)
  ses[[3]]<-c(4581+1,5358+1)
  ses[[4]]<-list(c(0+1,4580+1), c(6972+1,8638+1))
  
  segs<-list(NULL)
  segs[[1]]<-data.reg.analyze[ses[[1]][1]:ses[[1]][2],]
  segs[[2]]<-data.reg.analyze[ses[[2]][1]:ses[[2]][2],]
  segs[[3]]<-data.reg.analyze[ses[[3]][1]:ses[[3]][2],]
  segs[[4]]<-list(data.reg.analyze[ses[[4]][[1]][1]:ses[[4]][[1]][2],], data.reg.analyze[ses[[4]][[2]][1]:ses[[4]][[2]][2],])
  
  # m = length(ses)
  # segs<-list()
  # for(i in 1:m){
  #   seg<-list()
  #   
  # }
  # 
  # seg1[1]<-data.reg.analyze[se[1],se[2]]
  
  #��ÿһ�ν���VAR
  t_s<-Sys.time()
  seg.index<-1
  data<-segs[[seg.index]]
  prdRange<-50*60/10
  sampleEndIndex<-nrow(segs[[seg.index]])-prdRange
  col<-0
  source("VAR_Data_Analysis2.R")
  res<-func.var(data, sampleEndIndex, prdRange, col)
  res$colist[[5]]
  t_e<-Sys.time()
  t_e-t_s
  
  # #testfor.resample.var()
  # #����Ԥ�ⳤ��Ŀ����в���
  # -----------------------------------
  # #Ҫ�����ʱ�䳤�ȣ��룩
  # #browser()
  # time_vec<-c(NULL)
  # for(i in 1:12){
  #   time_vec[i]<-i*10
  # }
  # #Ҫ�����ʱ�䳤�ȣ����ӣ�
  # time_tmp<-c(3,4,5,10,20,30,40,50,60,90,120)*60
  # len<-length(time_tmp)
  # time_vec[13:23]<-time_tmp
  # 
  # #for(i in length(time_vec)){
  #   i = 23
  #   #browser()
  # 
  #   t_s<-Sys.time()
  #   seg.index<-4
  #   data<-segs[[seg.index]][[1]]
  #   prdRange<-time_vec[i]/10
  #   sampleEndIndex<-nrow(segs[[seg.index]][[1]])-prdRange
  #   col<-0
  #   source("VAR_Data_Analysis2.R")
  #   res<-func.var(data, sampleEndIndex, prdRange, col)
  #   t_e<-Sys.time()
  # 
  #   res$colist[[5]]
  #   t_e-t_s
  #   if(i <= 12){
  #     time_vec[i]
  #   }else{
  #     time_vec[i]/60
  #   }
  # 
  # #}

}