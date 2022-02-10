import sxtwl
import datetime
import shutil
    
def getJieQiName(date):
    jqmc = ["冬至", "小寒", "大寒", "立春", "雨水", "惊蛰", "春分", "清明", "谷雨", "立夏",
         "小满", "芒种", "夏至", "小暑", "大暑", "立秋", "处暑","白露", "秋分", "寒露", "霜降", 
         "立冬", "小雪", "大雪"]
         
    day = sxtwl.fromSolar(date.year, date.month, date.day)
    s = "公历:%d年%d月%d日" % (day.getSolarYear(), day.getSolarMonth(), day.getSolarDay())
    print(s)
    # 查找某日前后的节气,此例为之后，之前把after替换成before
    while True:
        # hasJieQi的接口比getJieQiJD速度要快，你也可以使用getJieQiJD来判断是否有节气。
        if day.hasJieQi():
            return jqmc[day.getJieQi()]
            #获取节气的儒略日数， 如果说你要计算什么时间的相距多少，直接比对儒略日要方便，相信我。
            jd = day.getJieQiJD()
            # 将儒略日数转换成年月日时秒
            t = sxtwl.JD2DD(jd )
            # 注意，t.s是小数，需要四舍五入
            print("节气时间:%d-%d-%d %d:%d:%d"%(t.Y, t.M, t.D, t.h, t.m, round(t.s)))
            break
        day = day.before(1)
     

jieqiname = getJieQiName(datetime.datetime.now())
print('节气：{}'.format(jieqiname))
shutil.copyfile('./image/{}.jpg'.format(jieqiname), './now.jpg')