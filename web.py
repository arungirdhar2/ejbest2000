import unittest
import os
from selenium.webdriver.common.by import By
from selenium.webdriver.support.ui import WebDriverWait
from selenium.webdriver.support import expected_conditions as EC
from selenium.webdriver.chrome.options import Options
from selenium import webdriver
import data as d
import sendEmail


options = Options()
options.add_argument('--headless')
options.add_argument('--disable-gpu')
chrome_path = os.path.abspath("chromedriver")

driver = webdriver.Chrome(chrome_path, chrome_options=options)

driver.maximize_window()

driver.implicitly_wait(120)
driver.get('http://'+d.server+':'+d.port+'/')
try:
    element = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.ID, "recnum"))
    )
    element.send_keys(d.recordNumber)

    element = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.ID, "vertag"))
    )
    element.send_keys(d.taxVersion)


    element = WebDriverWait(driver, 10).until(
        EC.presence_of_element_located((By.CSS_SELECTOR, "button"))
    )
    element.click()

    element = WebDriverWait(driver, 200).until(
        EC.presence_of_element_located((By.XPATH, "//div[@class='jumbotron']//tbody//tr[1]"))
    )
    elements = driver.find_elements_by_xpath("//div[@class='jumbotron']//tbody//tr")
    print(len(elements))

    sendEmail.main("From Web : ",str(len(elements)))

finally:
    driver.quit()

if __name__ == '__main__':
    unittest.main(verbosity=2)