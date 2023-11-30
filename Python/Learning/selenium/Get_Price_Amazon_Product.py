from selenium import  webdriver
from selenium.webdriver.common.by import By
#keep browser open
chrome_options = webdriver.ChromeOptions()
chrome_options.add_experimental_option("detach", True)
driver = webdriver.Chrome(options=chrome_options)
driver.get("https://www.amazon.co.uk/Insta360-Waterproof-Single-Lens-Stabilization-Touchscreen/dp/B0B9H572LC/ref=sr_1_4?crid=2HOGJONLAMUSY&keywords=insta+360+x3&qid=1696422228&sprefix=insta+360+x3%2Caps%2C119&sr=8-4&ufe=app_do%3Aamzn1.fos.cc223b57-2b86-485c-a85e-6431c1f06c86")
print(driver.title)

price_pounds = driver.find_element(By.CLASS_NAME, value="a-price-whole")
price_pence = driver.find_element(By.CLASS_NAME, value="a-price-fraction")

print (f"The price is {price_pounds.text} and {price_pence.text} pence")

#driver.close()
driver.quit()



#<span class="a-price-whole">459<span class="a-price-decimal">.</span></span>
#<span class="a-price-fraction">00</span>
#articlecount > a:nth-child(1)