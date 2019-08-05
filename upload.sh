#! /bin/bash
echo '开始验证'
pod spec lint MDSearchKit.podspec --use-libraries --allow-warnings --verbose
echo '开始推送'
pod trunk push MDSearchKit.podspec --allow-warnings --use-libraries --verbose
