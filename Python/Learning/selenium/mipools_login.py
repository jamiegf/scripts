
from selenium import  webdriver
from selenium.webdriver.common.keys import Keys #this gives keys like ENTER, SHIFT etc
from selenium.webdriver.common.by import By
#keep browser open
chrome_options = webdriver.ChromeOptions()
chrome_options.add_experimental_option("detach", True)
driver = webdriver.Chrome(options=chrome_options)
driver.get("https://authenticator.mipools.com/login?redirect=https:%2F%2Fwww.mipools.com%2F%23%2Fhome")

user_field = driver.find_element(By.XPATH, value='//*[@id="mat-input-0"]')
pass_field = driver.find_element(By.XPATH, value='//*[@id="mat-input-1"]')
login_button = driver.find_element(By.XPATH, value='/html/body/app-root/mipools-authenticator-login/div/div/form/button')



user_field.send_keys("jamie@jamiegf.com")
pass_field.send_keys("Selenium99!")
#pass_field.send_keys(Keys.ENTER)

login_button.click()

# log in
driver.get("https://www.mipools.com/#/home")
cookies_accept = driver.find_element(By.XPATH, value= '//*[@id="body"]/app-root/app-cookie-consent/div/div/div[3]/button[2]')
cookies_accept.click()

#body > app-root > nb-layout > div > div > div > div > div > nb-layout-column > mat-sidenav-container > mat-sidenav-content > landing > div > div:nth-child(3) > div.center-container > div > half-card:nth-child(1) > div > div.game-title
#driver.quit()




