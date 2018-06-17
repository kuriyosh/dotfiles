
((digest . "bc71bfb52ac45ec6cce65fb32d4a77c6") (undo-list (9421 . 9422) 9318 nil ("
" . -9421) ((marker . 9421) . -1) ((marker . 9318) . -1) ((marker . 9318) . -1) ((marker . 9395) . -1) 9422 nil ("ｋ" . -9422) ((marker . 9318) . -1) ((marker . 9395) . -1) (9422 . 9423) (t 23298 56069 654903 934000) nil (9318 . 9395) ("        model.save_weights(os.path.join('paras/',modelname + '-para.hdf5'))
" . 9318) (8893 . 9200) ("        hist = model.fit(   X_train,
                            T_train,
                            batch_size = BATCH_ROW_SIZE, epochs = n_epoch, callbacks=[early_stopping],
                            validation_data = (X_validation,
                                                T_validation))
" . 8893) (8772 . 8892) ("        model.compile(loss = 'categorical_crossentropy', optimizer = optimizer, metrics = ['accuracy'])
" . 8772) (8413 . 8490) ("        model.save_weights(os.path.join('paras/',modelname + '-para.hdf5'))
" . 8413) (7950 . 8295) ("        model.compile(loss = 'categorical_crossentropy', optimizer = optimizer, metrics = ['accuracy'])
        print('Training was Started.')        
        hist = model.fit(X_train, T_train, batch_size = BATCH_ROW_SIZE, epochs = n_epoch, callbacks=[early_stopping], validation_data = (X_validation, T_validation))
" . 7950) (7765 . 7892) ("        cp_cb = ModelCheckpoint(filepath = fpath, monitor='val_loss', verbose=1, save_best_only=False, mode='auto')
" . 7765) (7671 . 7672) ("    
" . 7671) (6698 . 6699) ("    
" . 6698) (6563 . 6586) ("        #print(value)
" . 6563) (6212 . 6213) ("    
" . 6212) (5992 . 6029) ("    X = np.array(X, dtype= \"float32\")
" . 5992) (5681 . 5927) ("    #Training Data
    X = pd.read_csv(filepath_or_buffer=\"data/\" + modelname + \"/\"+ x_name +\".csv\", sep=\",\")
    T = pd.read_csv(filepath_or_buffer=\"data/\" + modelname + \"/\"+ t_name +\".csv\", sep=\",\")
" . 5681) (5194 . 5532) ("    argparser.add_argument('mode', type=str,action = 'store', help='echo fname')
    argparser.add_argument('modelname', type = str, action = 'store', help = 'filename')
    argparser.add_argument('-x', type = str, action = 'store', required = True)
    argparser.add_argument('-t', type = str, action = 'store', required = True)
" . 5194) (5149 . 5150) ("            
" . 5149) (5018 . 5046) ("if __name__ == \"__main__\":
" . 5016) (4823 . 4977) ("    model = Model(inputs = [_input_month, _input_day, _input_hour, _input_minute, _input_weekday, _input_value], outputs = _output)
" . 4823) (4497 . 4742) ("    xx = BatchNormalization(axis=-1, momentum=0.99, epsilon=0.001, center=True, scale=True, beta_initializer='zeros', gamma_initializer='ones', moving_mean_initializer='zeros', moving_variance_initializer='ones')(xx)
" . 4497) (4141 . 4386) ("    xx = BatchNormalization(axis=-1, momentum=0.99, epsilon=0.001, center=True, scale=True, beta_initializer='zeros', gamma_initializer='ones', moving_mean_initializer='zeros', moving_variance_initializer='ones')(xx)
" . 4141) (4017 . 4117) ("    x = merge([x_month, x_day, x_hour, x_minute, x_weekday, x_value], mode = 'concat')
" . 4017) (3778 . 3836) ("    _input_value = Input(batch_shape = (None, maxlen, 2, ))
" . 3778) (3563 . 3623) ("    _input_weekday = Input(batch_shape = (None, maxlen,7, ))
" . 3563) (3355 . 3415) ("    _input_minute = Input(batch_shape = (None, maxlen,60, ))
" . 3355) (3166 . 3224) ("    _input_hour = Input(batch_shape = (None, maxlen,24, ))
" . 3166) (2986 . 3043) ("    _input_day = Input(batch_shape = (None, maxlen,31, ))
" . 2986) (2788 . 2847) ("    _input_month = Input(batch_shape = (None, maxlen, 12, ))
" . 2788) (2770 . 2771) (2507 . 2632) ("    plt.plot(history.history['loss'],\"o-\",label=\"loss\",)
    plt.plot(history.history['val_loss'],\"o-\",label=\"val_loss\")
" . 2507) (2220 . 2345) ("    plt.plot(history.history['acc'],\"o-\",label=\"accuracy\")
    plt.plot(history.history['val_acc'],\"o-\",label=\"val_acc\")
" . 2220) (2175 . 2176) (1910 . 1911) (1748 . 1749) (1654 . 1701) ("    xstd  = np.std(x, axis=axis, keepdims=True)
" . 1654) (1582 . 1609) ("def zscore(x, axis = None):
" . 1582) (1537 . 1538) (1518 . 1519) ("    
" . 1518) (1413 . 1455) ("        if d1 == d2 or (d1%28)+1 == d2:
" . 1413) (1290 . 1332) ("        if d1 == d2 or (d1%30)+1 == d2:
" . 1290) (1155 . 1197) ("        if d1 == d2 or (d1%31)+1 == d2:
" . 1155) (980 . 981) (832 . 866) ("matplotlib.use('Agg') # -----(1)
" . 832) (t 23298 56056 297548 524000) nil (9230 . 9231) 1 nil ("
" . 9230) ((marker . 9421) . -1) ((marker . 9421) . -1) (t 23298 56012 53578 103000) nil (832 . 865) ("matplotlib.use('Agg')  # -----(1)
" . 832) ("
" . 980) (1155 . 1195) ("        if d1 == d2 or (d1 % 31)+1 == d2:
" . 1155) (1290 . 1330) ("        if d1 == d2 or (d1 % 30)+1 == d2:
" . 1290) (1413 . 1453) ("        if d1 == d2 or (d1 % 28)+1 == d2:
" . 1413) (1518 . 1523) ("
" . 1518) ("
" . 1537) (1582 . 1610) ("
def zscore(x, axis=None):
" . 1582) (1654 . 1702) ("    xstd = np.std(x, axis=axis, keepdims=True)
" . 1654) ("
" . 1748) ("
" . 1910) ("
" . 2175) (2220 . 2341) ("    plt.plot(history.history['acc'], \"o-\", label=\"accuracy\")
    plt.plot(history.history['val_acc'], \"o-\", label=\"val_acc\")
" . 2220) (2507 . 2628) ("    plt.plot(history.history['loss'], \"o-\", label=\"loss\",)
    plt.plot(history.history['val_loss'], \"o-\", label=\"val_loss\")
" . 2507) ("
" . 2770) (2788 . 2849) ("    _input_month = Input(batch_shape=(None, maxlen, 12, ))
" . 2788) (2986 . 3044) ("    _input_day = Input(batch_shape=(None, maxlen, 31, ))
" . 2986) (3166 . 3225) ("    _input_hour = Input(batch_shape=(None, maxlen, 24, ))
" . 3166) (3355 . 3416) ("    _input_minute = Input(batch_shape=(None, maxlen, 60, ))
" . 3355) (3563 . 3624) ("    _input_weekday = Input(batch_shape=(None, maxlen, 7, ))
" . 3563) ((marker) . -60) ((marker) . -60) (3778 . 3838) ("    _input_value = Input(batch_shape=(None, maxlen, 2, ))
" . 3778) ((marker) . -58) ((marker) . -58) (4017 . 4104) ("    x = merge([x_month, x_day, x_hour, x_minute,
               x_weekday, x_value], mode='concat')
" . 4017) ((marker) . -100) ((marker) . -100) ((marker) . -49) ((marker) . -49) ((marker . 4017) . -4) ((marker . 4017) . -4) ((marker . 4017) . -4) ((marker . 4017) . -8) (4141 . 4358) ("    xx = BatchNormalization(axis=-1, momentum=0.99, epsilon=0.001, center=True, scale=True, beta_initializer='zeros',
                            gamma_initializer='ones', moving_mean_initializer='zeros', moving_variance_initializer='ones')(xx)
" . 4141) ((marker) . -245) ((marker) . -245) ((marker) . -118) ((marker) . -118) ((marker . 4141) . -4) ((marker . 4141) . -4) ((marker . 4141) . -47) ((marker . 4141) . -4) ((marker . 4141) . -4) ((marker . 4141) . -4) ((marker . 4141) . -47) ((marker . 4141) . -4) ((marker . 4141) . -4) ((marker . 4141) . -4) ((marker . 4141) . -47) ((marker . 4141) . -4) ((marker . 4141) . -4) ((marker . 4141) . -4) ((marker . 4141) . -47) (4497 . 4714) ("    xx = BatchNormalization(axis=-1, momentum=0.99, epsilon=0.001, center=True, scale=True, beta_initializer='zeros',
                            gamma_initializer='ones', moving_mean_initializer='zeros', moving_variance_initializer='ones')(xx)
" . 4497) ((marker) . -245) ((marker) . -245) ((marker) . -118) ((marker) . -118) ((marker . 4497) . -4) ((marker . 4497) . -4) ((marker . 4497) . -47) ((marker . 4497) . -4) ((marker . 4497) . -4) ((marker . 4497) . -4) ((marker . 4497) . -47) ((marker . 4497) . -4) ((marker . 4497) . -4) ((marker . 4497) . -4) ((marker . 4497) . -47) ((marker . 4497) . -4) ((marker . 4497) . -4) ((marker . 4497) . -4) ((marker . 4497) . -47) (4823 . 4955) ("    model = Model(inputs=[_input_month, _input_day, _input_hour,
                          _input_minute, _input_weekday, _input_value], outputs=_output)
" . 4823) ((marker) . -154) ((marker) . -154) ((marker) . -65) ((marker) . -65) (5016 . 5043) ("if __name__ == \"__main__\":

" . 5018) ((marker) . -27) ((marker) . -27) ((marker) . -28) ((marker) . -28) (5149 . 5162) ("
" . 5149) ((marker . 9318) . -1) ((marker) . -1) ((marker) . -1) ((marker . 9318) . -1) (5194 . 5524) ("    argparser.add_argument('mode', type=str, action='store', help='echo fname')
    argparser.add_argument('modelname', type=str,
                           action='store', help='filename')
    argparser.add_argument('-x', type=str, action='store', required=True)
    argparser.add_argument('-t', type=str, action='store', required=True)
" . 5194) ((marker . 5194) . -4) ((marker . 5194) . -4) ((marker . 5194) . -4) ((marker . 5194) . -4) ((marker . 5194) . -4) ((marker . 5194) . -4) ((marker . 5194) . -84) ((marker . 5194) . -84) ((marker . 5194) . -84) ((marker . 5194) . -84) ((marker . 5194) . -84) ((marker . 5194) . -84) ((marker . 5194) . -84) ((marker . 5194) . -84) ((marker . 5194) . -194) ((marker . 5194) . -194) ((marker . 5194) . -194) ((marker . 5194) . -194) ((marker . 5194) . -268) ((marker . 5194) . -268) ((marker . 5194) . -268) ((marker . 5194) . -268) ((marker) . -80) ((marker) . -80) ((marker) . -130) ((marker) . -130) ((marker) . -190) ((marker) . -190) ((marker) . -264) ((marker) . -264) ((marker) . -338) ((marker) . -338) (5681 . 5882) ("    # Training Data
    X = pd.read_csv(filepath_or_buffer=\"data/\" + modelname +
                    \"/\" + x_name + \".csv\", sep=\",\")
    T = pd.read_csv(filepath_or_buffer=\"data/\" + modelname +
                    \"/\" + t_name + \".csv\", sep=\",\")
" . 5681) ((marker . 5681) . -24) ((marker . 5681) . -24) ((marker . 5681) . -60) ((marker . 5681) . -24) ((marker . 5681) . -24) ((marker . 5681) . -24) ((marker . 5681) . -60) ((marker . 5681) . -24) ((marker . 5681) . -24) ((marker . 5681) . -24) ((marker . 5681) . -60) ((marker . 5681) . -24) ((marker . 5681) . -24) ((marker . 5681) . -24) ((marker . 5681) . -60) ((marker . 5681) . -137) ((marker . 5681) . -137) ((marker . 5681) . -173) ((marker . 5681) . -137) ((marker . 5681) . -137) ((marker . 5681) . -137) ((marker . 5681) . -173) ((marker . 5681) . -137) ((marker . 5681) . -137) ((marker . 5681) . -137) ((marker . 5681) . -173) ((marker . 5681) . -137) ((marker . 5681) . -137) ((marker . 5681) . -137) ((marker . 5681) . -173) ((marker) . -20) ((marker) . -20) ((marker) . -81) ((marker) . -81) ((marker) . -133) ((marker) . -133) ((marker) . -194) ((marker) . -194) (5992 . 6030) ("    X = np.array(X, dtype=\"float32\")
" . 5992) (6212 . 6217) ("
" . 6212) (6563 . 6585) ("        # print(value)
" . 6563) (6698 . 6703) ("
" . 6698) (7671 . 7676) ("
" . 7671) (7765 . 7881) ("        cp_cb = ModelCheckpoint(
            filepath=fpath, monitor='val_loss', verbose=1, save_best_only=False, mode='auto')
" . 7765) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -16) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -16) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -16) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -16) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -16) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -16) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -16) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -8) ((marker . 7765) . -16) (7950 . 8267) ("        model.compile(loss='categorical_crossentropy',
                      optimizer=optimizer, metrics=['accuracy'])
        print('Training was Started.')
        hist = model.fit(X_train, T_train, batch_size=BATCH_ROW_SIZE, epochs=n_epoch, callbacks=[
                         early_stopping], validation_data=(X_validation, T_validation))
" . 7950) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -128) ((marker . 7950) . -128) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -128) ((marker . 7950) . -128) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -128) ((marker . 7950) . -128) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -8) ((marker . 7950) . -128) ((marker . 7950) . -128) (8413 . 8489) ("        model.save_weights(os.path.join('paras/', modelname + '-para.hdf5'))
" . 8413) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) ((marker . 8413) . -8) (8772 . 8876) ("        model.compile(loss='categorical_crossentropy',
                      optimizer=optimizer, metrics=['accuracy'])
" . 8772) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) ((marker . 8772) . -8) (8893 . 9194) ("        hist = model.fit(X_train,
                         T_train,
                         batch_size=BATCH_ROW_SIZE, epochs=n_epoch, callbacks=[
                             early_stopping],
                         validation_data=(X_validation,
                                          T_validation))
" . 8893) (9318 . 9394) ("        model.save_weights(os.path.join('paras/', modelname + '-para.hdf5'))
" . 9318) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker . 9318) . -8) ((marker* . 9395) . 77) ((marker* . 9395) . 77) nil (9318 . 9395) ("        model.save_weights(os.path.join('paras/',modelname + '-para.hdf5'))
" . 9318) (8893 . 9200) ("        hist = model.fit(   X_train,
                            T_train,
                            batch_size = BATCH_ROW_SIZE, epochs = n_epoch, callbacks=[early_stopping],
                            validation_data = (X_validation,
                                                T_validation))
" . 8893) (8772 . 8892) ("        model.compile(loss = 'categorical_crossentropy', optimizer = optimizer, metrics = ['accuracy'])
" . 8772) (8413 . 8490) ("        model.save_weights(os.path.join('paras/',modelname + '-para.hdf5'))
" . 8413) (7950 . 8295) ("        model.compile(loss = 'categorical_crossentropy', optimizer = optimizer, metrics = ['accuracy'])
        print('Training was Started.')        
        hist = model.fit(X_train, T_train, batch_size = BATCH_ROW_SIZE, epochs = n_epoch, callbacks=[early_stopping], validation_data = (X_validation, T_validation))
" . 7950) (7765 . 7892) ("        cp_cb = ModelCheckpoint(filepath = fpath, monitor='val_loss', verbose=1, save_best_only=False, mode='auto')
" . 7765) (7671 . 7672) ("    
" . 7671) (6698 . 6699) ("    
" . 6698) (6563 . 6586) ("        #print(value)
" . 6563) (6212 . 6213) ("    
" . 6212) (5992 . 6029) ("    X = np.array(X, dtype= \"float32\")
" . 5992) (5681 . 5927) ("    #Training Data
    X = pd.read_csv(filepath_or_buffer=\"data/\" + modelname + \"/\"+ x_name +\".csv\", sep=\",\")
    T = pd.read_csv(filepath_or_buffer=\"data/\" + modelname + \"/\"+ t_name +\".csv\", sep=\",\")
" . 5681) (5194 . 5532) ("    argparser.add_argument('mode', type=str,action = 'store', help='echo fname')
    argparser.add_argument('modelname', type = str, action = 'store', help = 'filename')
    argparser.add_argument('-x', type = str, action = 'store', required = True)
    argparser.add_argument('-t', type = str, action = 'store', required = True)
" . 5194) (5149 . 5150) ("            
" . 5149) (5018 . 5046) ("if __name__ == \"__main__\":
" . 5016) (4823 . 4977) ("    model = Model(inputs = [_input_month, _input_day, _input_hour, _input_minute, _input_weekday, _input_value], outputs = _output)
" . 4823) (4497 . 4742) ("    xx = BatchNormalization(axis=-1, momentum=0.99, epsilon=0.001, center=True, scale=True, beta_initializer='zeros', gamma_initializer='ones', moving_mean_initializer='zeros', moving_variance_initializer='ones')(xx)
" . 4497) (4141 . 4386) ("    xx = BatchNormalization(axis=-1, momentum=0.99, epsilon=0.001, center=True, scale=True, beta_initializer='zeros', gamma_initializer='ones', moving_mean_initializer='zeros', moving_variance_initializer='ones')(xx)
" . 4141) (4017 . 4117) ("    x = merge([x_month, x_day, x_hour, x_minute, x_weekday, x_value], mode = 'concat')
" . 4017) (3778 . 3836) ("    _input_value = Input(batch_shape = (None, maxlen, 2, ))
" . 3778) (3563 . 3623) ("    _input_weekday = Input(batch_shape = (None, maxlen,7, ))
" . 3563) (3355 . 3415) ("    _input_minute = Input(batch_shape = (None, maxlen,60, ))
" . 3355) (3166 . 3224) ("    _input_hour = Input(batch_shape = (None, maxlen,24, ))
" . 3166) (2986 . 3043) ("    _input_day = Input(batch_shape = (None, maxlen,31, ))
" . 2986) (2788 . 2847) ("    _input_month = Input(batch_shape = (None, maxlen, 12, ))
" . 2788) (2770 . 2771) (2507 . 2632) ("    plt.plot(history.history['loss'],\"o-\",label=\"loss\",)
    plt.plot(history.history['val_loss'],\"o-\",label=\"val_loss\")
" . 2507) (2220 . 2345) ("    plt.plot(history.history['acc'],\"o-\",label=\"accuracy\")
    plt.plot(history.history['val_acc'],\"o-\",label=\"val_acc\")
" . 2220) (2175 . 2176) (1910 . 1911) (1748 . 1749) (1654 . 1701) ("    xstd  = np.std(x, axis=axis, keepdims=True)
" . 1654) ((marker) . -48) ((marker) . -48) (1582 . 1609) ("def zscore(x, axis = None):
" . 1582) ((marker) . -28) ((marker) . -28) (1537 . 1538) (1518 . 1519) ("    
" . 1518) ((marker) . -5) ((marker) . -5) (1413 . 1455) ("        if d1 == d2 or (d1%28)+1 == d2:
" . 1413) ((marker) . -40) ((marker) . -40) (1290 . 1332) ("        if d1 == d2 or (d1%30)+1 == d2:
" . 1290) ((marker) . -40) ((marker) . -40) (1155 . 1197) ("        if d1 == d2 or (d1%31)+1 == d2:
" . 1155) ((marker) . -40) ((marker) . -40) (980 . 981) (832 . 866) ("matplotlib.use('Agg') # -----(1)
" . 832) ((marker) . -33) ((marker) . -33) (t 23298 56012 53578 103000) nil (9230 . 9231) 5573))
