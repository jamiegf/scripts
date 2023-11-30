from selenium import  webdriver
from selenium.webdriver.common.by import By
#keep browser open
chrome_options = webdriver.ChromeOptions()
chrome_options.add_experimental_option("detach", True)
driver = webdriver.Chrome(options=chrome_options)
driver.get("https://www.python.org/")
print(driver.title)


search_bar = driver.find_element(By.NAME, value="q")
print(search_bar.tag_name) #if we dont use .tag_name, we will get the element instead (which we do not want)
#driver.close()
driver.quit()



#<span class="a-price-whole">459<span class="a-price-decimal">.</span></span>
#<span class="a-price-fraction">00</span>
#articlecount #articlecount