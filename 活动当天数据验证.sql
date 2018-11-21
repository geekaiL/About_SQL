set mapred.job.queue.name=root.hive;
set mapred.max.split.size=100000000;
set mapred.min.split.size.per.node=100000000;
set mapred.min.split.size.per.rack=100000000;
set hive.input.format=org.apache.hadoop.hive.ql.io.CombineHiveInputFormat;

add jar /mnt/disk1/stg/hive_udf-1.0-SNAPSHOT.jar;
add file /mnt/disk1/stg/GeoLite2-City.mmdb;
create temporary function getaddress as 'com.ks.bigdata.udf.IPToCC';
select  
count(get_json_object(get_json_object(jsondata,'$.pagelog'),'$.userid'))
,count(distinct get_json_object(get_json_object(jsondata,'$.pagelog'),'$.userid'))
,count(get_json_object(get_json_object(jsondata,'$.pagelog'),'$.project'))
from src.src_page_logs_oss
where year='2018' and month='11' and day='12'
and get_json_object(get_json_object(jsondata,'$.pagelog'),'$.page') = 'act_double11_page'