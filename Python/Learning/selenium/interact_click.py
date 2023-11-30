from selenium import  webdriver
from selenium.webdriver.common.by import By
#keep browser open
chrome_options = webdriver.ChromeOptions()
chrome_options.add_experimental_option("detach", True)
driver = webdriver.Chrome(options=chrome_options)
driver.get("https://en.wikipedia.org/wiki/Main_Page")

wiki_count = driver.find_element(By.XPATH, value='//*[@id="articlecount"]/a[1]')
print(wiki_count.text)
wiki_count.click()

#driver.quit()