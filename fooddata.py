import json
import numpy as np
import requests
import pandas

#http://ndb.nal.usda.gov/ndb/foods
#search for foods at this link, input the food code you desire
#when you are done, input 0 to end the program, go to your folder and find nutrition.csv
#sugar is the part of carbs that is in the form of simple carbohydrates (monomers)

class foodn:

	def __init__(self,inputid):
		self.foodid=inputid
		self.food=requests.get('http://api.nal.usda.gov/ndb/reports/?ndbno='+str(self.foodid)+'&type=b&format=json&api_key=ojvUWW6ma2wjGMW6928r0cCHWtGgv9OgAL9RRs3P')
		self.fooddata=self.food.json()
		self.nutrition={'name':[],'kcal':[],'protein':[],'fat':[],'carb':[],'fiber':[],'sugar':[]}
		self.nutrition['name']=str(self.fooddata['report']['food']['name'])
		for i, v in enumerate(['kcal', 'protein','fat','carb','fiber','sugar']):
			self.nutrition[v]=float(str(self.fooddata['report']['food']['nutrients'][i+1]['value']))

	def givenutrition(self):
		return np.array([[self.nutrition['name'], self.nutrition['kcal'], self.nutrition['protein'], self.nutrition['fat'], self.nutrition['carb'], self.nutrition['fiber'], self.nutrition['sugar']]])

foodItems = 100;
whole=np.zeros((foodItems,7))
foodInfo=np.array(whole,dtype='str')

for i in range(0,foodItems):
	userinput=raw_input('put a food id: ')
	intuser=int(userinput)
	if intuser == 0:
		break
	currentfood=foodn(str(userinput))
	foodInfo[i,:]=currentfood.givenutrition()

df3=pandas.DataFrame(foodInfo, columns=['name', 'kcal', 'protein', 'fat', 'carb','fiber','sugar'])
df3.to_csv('nutrition.csv')





