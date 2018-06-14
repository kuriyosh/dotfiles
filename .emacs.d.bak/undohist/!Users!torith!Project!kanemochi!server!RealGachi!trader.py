
((digest . "29d6d63b73c015f477851090f1f82984") (undo-list nil ("new_" . -5397) ((marker . 5397) . -4) 5401 nil ("
" . -6031) ((marker . 6027) . -1) ((marker . 6027) . -1) ((marker . 6027) . -1) ((marker . 6027) . -1) ((marker . 6027) . -1) ((marker . 6027) . -1) ((marker . 6027) . -1) ((marker . 6027) . -1) ((marker . 7724) . -1) ((marker . 7724) . -1) ((marker . 5397) . -1) ((marker . 6027) . -1) ((marker . 6027) . -1) ((marker . 5389) . -1) ("            # print(type(values[0]))
            # t_utc = datetime.strptime(values[0], '%Y-%m-%d %H:%M:%S').replace(tzinfo=timezone('UTC'))
            # t = t_utc.astimezone(timezone(self.tzone))" . -6032) ((marker . 6028) . -37) ((marker . 6028) . -37) ((marker . 6087) . -141) ((marker . 6087) . -141) ((marker . 5397) . -197) ((marker) . -197) ((marker*) . 1) ((marker) . -197) ((marker*) . 22) ((marker) . -197) ((marker . 5389) . -141) ((marker . 6027) . -196) ((marker . 6027) . -197) 6229 nil ("
" . -6798) ((marker . 6027) . -1) ((marker . 6596) . -1) ((marker . 4538) . -1) ((marker . 4538) . -1) ((marker . 5397) . -1) ((marker . 5389) . -1) ("
" . -6799) ((marker . 6027) . -1) ((marker . 6596) . -1) ((marker . 6606) . -1) ((marker . 6606) . -1) ((marker . 5397) . -1) ((marker . 5389) . -1) 6800 nil ("    '''
    過去レートを取得
    '''
    def get_history(self,start,count):

        def timeRound(t):
            if self.granularity == 'M':
                return t.replace(day=0)
            elif 'M' in self.granularity:
                return t.replace(second=0)
            elif 'H' in self.granularity:
                return t.replace(minute=0)
            elif 'D' in self.granularity:
                return t.replace(hour=0)
            else:
                self.tsuchi_kun.send_text('Error', \"timeRound()\")
                return t

        #set day
        st = datetime.strptime(start, '%Y-%m-%dT%H:%M:%S').astimezone(timezone(self.tzone))
        st = timeRound(st) # 時刻の丸め
        st_utc = st.astimezone(timezone('UTC'))
        resultList = []

        # 取得
        c = count + 15
        st_utc += timedelta(minutes = -15)
        status, data = oanda_function.get_history(self.instrument, self.granularity, st_utc.isoformat(), c, self.tzone)
        if status == 'Error':
            self.tsuchi_kun.send_text('Error', \"get_history(): {}\".format(str(data)))
            return

        #　データの作成
        t_utc_prev = st_utc
        compensation_counter = 0
        for d in data[\"candles\"]:
            values = list(d.values())
            t_utc = datetime.strptime(values[0], '%Y-%m-%dT%H:%M:%S.%fZ').replace(tzinfo=timezone('UTC'))
            t = t_utc.astimezone(timezone(self.tzone))

            # データ抜け落ちカバー
            while t_utc > t_utc_prev + self.granularity_time():
                if calender.isWeekday(t_utc_prev.strftime(\"%Y-%m-%dT%H:%M:%S\"), self.tzone):
                    if len(resultList) == 0:
                        break
                    t_utc_prev += self.granularity_time()
                    t_prev=t_utc_prev.astimezone(timezone(self.tzone))
                    result = [t_prev.strftime('%Y'), t_prev.strftime('%m'), t_prev.strftime('%d'), t_prev.strftime('%H'), t_prev.strftime('%M'), t_prev.strftime('%S'), t_prev.weekday()]
                    tail=resultList[-1]
                    result.extend(tail[7:]) # レスポンスの時刻は除外
                    result[15]=0
                    #result[16]='flase'
                    resultList.append(result)
                    compensation_counter += 1

            #　結果書き込み
            result = [t.strftime('%Y'), t.strftime('%m'), t.strftime('%d'), t.strftime('%H'), t.strftime('%M'), t.strftime('%S'), t.weekday()]
            result.extend(values[1:]) # レスポンス内の時刻は除外
            resultList.append(result)

            t_utc_prev = t_utc

        self.compensation = compensation_counter
        print(\"compensation: {}/{}\".format(compensation_counter,len(resultList)))
        resultList = resultList[-count:]
        print(\"oldest: {0[0]}-{0[1]}-{0[2]} {0[3]}:{0[4]}:{0[5]}\".format(resultList[0]))
        print(\"latest: {0[0]}-{0[1]}-{0[2]} {0[3]}:{0[4]}:{0[5]}\".format(resultList[-1]))
        print(resultList)
        return resultList" . -6800) ((marker . 5364) . -1240) ((marker . 5364) . -1240) ((marker . 5381) . -1346) ((marker . 5381) . -1346) ((marker . 5389) . -1401) ((marker . 5389) . -1401) ((marker . 5428) . -1402) ((marker . 5428) . -1402) ((marker . 5520) . -1427) ((marker . 5520) . -1427) ((marker . 5568) . -1491) ((marker . 5568) . -1491) ((marker . 5627) . -1584) ((marker . 5627) . -1584) ((marker . 5681) . -1629) ((marker . 5681) . -1629) ((marker . 5825) . -1659) ((marker . 5825) . -1659) ((marker . 7601) . -2191) ((marker . 7601) . -2191) ((marker . 7633) . -2145) ((marker . 7633) . -2145) ((marker . 7662) . -2105) ((marker . 7662) . -2105) ((marker . 5967) . -2072) ((marker . 5967) . -2072) ((marker . 5943) . -2014) ((marker . 5943) . -2014) ((marker . 5942) . -1974) ((marker . 5942) . -1974) ((marker . 5900) . -1788) ((marker . 5900) . -1788) ((marker . 5863) . -1717) ((marker . 5863) . -1717) ((marker . 7533) . -2259) ((marker . 7533) . -2259) ((marker . 7501) . -2402) ((marker . 7501) . -2402) ((marker . 7138) . -2903) ((marker . 7138) . -2903) ((marker . 7170) . -2877) ((marker . 7170) . -2877) ((marker . 7208) . -2787) ((marker . 7208) . -2787) ((marker . 7236) . -2698) ((marker . 7236) . -2698) ((marker . 7287) . -2657) ((marker . 7287) . -2657) ((marker . 7336) . -2575) ((marker . 7336) . -2575) ((marker . 5356) . -1202) ((marker . 5356) . -1202) ((marker . 7354) . -2526) ((marker . 7354) . -2526) ((marker . 7372) . -2525) ((marker . 7372) . -2525) ((marker . 7400) . -2494) ((marker . 7400) . -2494) ((marker . 7440) . -2493) ((marker . 7440) . -2493) ((marker . 7475) . -2455) ((marker . 7475) . -2455) ((marker . 7587) . -2237) ((marker . 7587) . -2237) ((marker . 7560) . -2238) ((marker . 7560) . -2238) ((marker . 5355) . -1168) ((marker . 5355) . -1168) ((marker . 6596) . -1070) ((marker . 4539) . -8) ((marker . 4539) . -8) ((marker . 4572) . -21) ((marker . 4572) . -21) ((marker . 4606) . -29) ((marker . 4606) . -29) ((marker . 4607) . -68) ((marker . 4607) . -68) ((marker . 4639) . -69) ((marker . 4639) . -69) ((marker . 4672) . -95) ((marker . 4672) . -95) ((marker . 4673) . -135) ((marker . 4673) . -135) ((marker . 4706) . -175) ((marker . 4706) . -175) ((marker . 4740) . -217) ((marker . 4740) . -217) ((marker . 4741) . -260) ((marker . 4741) . -260) ((marker . 4771) . -302) ((marker . 4771) . -302) ((marker . 4802) . -345) ((marker . 4802) . -345) ((marker . 4803) . -387) ((marker . 4803) . -387) ((marker . 4836) . -428) ((marker . 4836) . -428) ((marker . 4871) . -446) ((marker . 4871) . -446) ((marker . 4872) . -512) ((marker . 4872) . -512) ((marker . 4873) . -537) ((marker . 4873) . -537) ((marker . 4881) . -538) ((marker . 4881) . -538) ((marker . 4894) . -555) ((marker . 4894) . -555) ((marker . 4902) . -647) ((marker . 4902) . -647) ((marker . 4903) . -682) ((marker . 4903) . -682) ((marker . 4935) . -730) ((marker . 4935) . -730) ((marker . 5003) . -754) ((marker . 5003) . -754) ((marker . 5004) . -755) ((marker . 5004) . -755) ((marker . 5034) . -768) ((marker . 5034) . -768) ((marker . 5125) . -791) ((marker . 5125) . -791) ((marker . 5146) . -834) ((marker . 5146) . -834) ((marker . 5167) . -954) ((marker . 5167) . -954) ((marker . 5181) . -984) ((marker . 5181) . -984) ((marker . 5235) . -1070) ((marker . 5235) . -1070) ((marker . 5289) . -1089) ((marker . 5289) . -1089) ((marker . 5321) . -1090) ((marker . 5321) . -1090) ((marker . 5353) . -1107) ((marker . 5353) . -1107) ((marker . 5354) . -1135) ((marker . 5354) . -1135) ((marker . 5397) . -2928) ((marker) . -2928) ((marker . 5389) . -2903) 9728 nil ("e" . -6031) ((marker . 601) . -1) 6032 nil (6031 . 6032) (t 23320 44349 0 0) nil ("            
" . 6032) ((marker . 6027) . -12) ((marker . 6027) . -12) ((marker . 6027) . -12) ((marker . 6027) . -12) ((marker . 6027) . -12) ((marker . 6027) . -12) ((marker . 6027) . -12) ((marker . 5428) . -13) nil ("print(" . 6044) ((marker . 601) . -5) ((marker . 6027) . -5) ((marker . 6027) . -5) ((marker . 6027) . -5) ((marker . 6027) . -5) ((marker . 6027) . -5) ((marker . 6027) . -5) ((marker) . -5) ((marker) . -5) ((marker . 6027) . -5) (6049 . 6050) ("()" . 6049) ((marker . 601) . -1) ((marker . 6027) . -1) ((marker) . -2) ((marker . 6027) . -2) nil (6049 . 6051) ("(" . -6049) ((marker . 6027) . -1) ((marker . 6027) . -1) (6044 . 6050) nil (6031 . 6044) (t 23320 44340 0 0) nil ("e" . -6030) ((marker . 601) . -1) 6031 nil (6030 . 6031) nil (6230 . 6242) nil ("    " . -6230) ((marker . 601) . -4) 6234 nil ("    " . -6234) ((marker . 601) . -4) 6238 nil ("    " . -6238) ((marker . 601) . -4) 6242 nil (" " . -6242) 6230 nil (6242 . 6243) nil ("." . -6031) ((marker . 601) . -1) 6032 nil (6031 . 6032) (t 23318 18796 0 0)))
