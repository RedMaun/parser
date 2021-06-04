import time
import json
import html2text
from selenium import webdriver
from selenium.webdriver.common.keys import Keys
from selenium.webdriver.firefox.options import Options

with open('config.json') as f:
    data = json.load(f)

options = Options()
options.headless = True
driver = webdriver.Firefox(options=options)
h = html2text.HTML2Text()
driver.get(data["school"] + "/authorize")
driver.find_element_by_xpath("//*[@type='text']").send_keys(data["login"])
driver.find_element_by_xpath("//*[@type='password']").send_keys(data["password"])
driver.find_element_by_class_name('field').send_keys(Keys.ENTER)
time.sleep(3)
driver.get(data["school"] + "/journal-app/u.43433")
content = driver.page_source
driver.close()
print(h.handle(content))
