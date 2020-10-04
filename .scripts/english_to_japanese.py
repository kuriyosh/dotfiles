#!/usr/bin/env python
# -*- coding: utf-8 -*-

'''
@file english_to_japanese.py
@brief
@date 2019-12-12
@author kuriyosh
'''
import boto3
import pyperclip

# constant
REGION = 'ap-northeast-1'
SRC_LANG = 'en'
TRG_LANG = 'ja'


def get_translate_text(text):

    translate = boto3.client('translate', region_name=REGION)

    response = translate.translate_text(
        Text=text,
        SourceLanguageCode=SRC_LANG,
        TargetLanguageCode=TRG_LANG
    )

    return response


def main():
    # Text to translate
    text = pyperclip.paste()

    # From English to Japanese
    while len(text) > 5000:
        text = text[:-1]

    result = get_translate_text(text)
    print(result.get('TranslatedText'))


if __name__ == '__main__':
    main()
