from selenium import  webdriver
from selenium.webdriver.common.by import By
#keep browser open
chrome_options = webdriver.ChromeOptions()
chrome_options.add_experimental_option("detach", True)
driver = webdriver.Chrome(options=chrome_options)
driver.get("https://en.wikipedia.org/wiki/Main_Page")



search_bar = driver.find_element(By.NAME, value="search")
print(search_bar.tag_name) #if we dont use .tag_name, we will get the element instead (which we do not want)
#driver.close()
driver.quit()