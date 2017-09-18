'''
CMPE 452 Project
Pre-processing the Platformer Experience Dataset
Revised Version For Better Data
Matt Hahn
'''

from os import listdir
from os.path import isfile, join

mypath = "C:\Users\Matt\Documents\Queen's\Fourth Year\CMPE 452\Project\Platformer Experience Dataset\Platformer Experience Dataset"
	
def toBinary(val):
	if (val == '0') or (val == '1'):
		val = '0'
	else:
		val = '1'
	
	return val
	

outputFileProcessed = open("processed.txt", 'w')
outputFileProcessed.write(	"\n\nPre-Processed Platformer Experience Dataset, revised for better performance\n\n"
							"Column 1: win_A\n" +
							"Column 2: powerUpSum_A\n" +
							"Column 3: numDeaths_A\n" +
							"Column 4: totalTime_A\n" +
							"Column 5: win_B\n" +
							"Column 6: powerUpSum_B\n" +
							"Column 7: numDeaths_B\n" +
							"Column 8: totalTime_B\n" +
							"Column 9: age\n" +
							"Column 10: playedBefore\n" +
							"Column 11: timePlayingGames\n" +
							"Column 12: playGames\n" +
							"Column 13: pairsPlayed\n" +
							"Column 14: engagementRanking_A\n" +
							"Column 15: frustrationRanking_A\n" +
							"Column 16: challengeRanking_A\n" +
							"Column 17: engagementRanking_B\n" +
							"Column 18: frustrationRanking_B\n" +
							"Column 19: challengeRanking_B\n\n")

# Each directory corresponds to a person
for dir in listdir(mypath):
	
	# only want the directories, ignore other files in the dataset (such as the readme).
	if ( isfile(join(mypath, dir)) == False ):
	
		# Metrics
		win_A = 0
		powerUpSum_A = 0
		numDeaths_A = 0
		totalTime_A = 0
		
		win_B = 0
		powerUpSum_B = 0
		numDeaths_B = 0
		totalTime_B = 0
		
		age = 0
		playedBefore = 0
		timePlayingGames = 0
		playGames = 0
		
		pairsPlayed = 0
		
		# Preferences
		engagementRanking_A = 0
		frustrationRanking_A = 0
		challengeRanking_A = 0
		
		engagenemtRanking_B = 0
		frustrationRanking_B = 0
		challengeRanking_B = 0
		
		# A game data
		A_filePath = mypath + "\\" + dir + "\\" + "1_A.csv"
		A_data = open(A_filePath, "r+")
		line = A_data.readline()
		while(line != ""):
			
			# win metric
			if "-19" in line:
				win_A = 1
				numDeaths_A = numDeaths_A - 1 # adjust number of deaths
				
			# powerup sum
			if ",221" in line:
				powerUpSum_A = powerUpSum_A + 1
				
			# num deaths
			if "Level_End" in line:
				_line_split = line.split(",")
				totalTime_A = totalTime_A + int(_line_split[0])
				numDeaths_A = numDeaths_A + 1
				
			line = A_data.readline()
			
		# B game data
		B_filePath = mypath + "\\" + dir + "\\" + "1_B.csv"
		B_data = open(B_filePath, "r+")
		line = B_data.readline()
		while(line != ""):
			
			# win metric
			if "-19" in line:
				win_B = 1
				numDeaths_B = numDeaths_B - 1 # adjust number of deaths
				
			# powerup sum
			if ",221" in line:
				powerUpSum_B = powerUpSum_B + 1
				
			# num deaths
			if "Level_End" in line: 
				_line_split = line.split(",")
				totalTime_B = totalTime_B + int(_line_split[0])
				numDeaths_B = numDeaths_B + 1
			
			line = B_data.readline()
			
		# Preference data
		pref_filePath = mypath + "\\" + dir + "\\" + "Pref.csv"
		pref_data = open(pref_filePath, "r+")
		line = pref_data.readline()
		while(line != ""):
		
			pairsPlayed = pairsPlayed + 1

			format_line = line.split(",")
			if (format_line[0] == '1'): # only want the preferences for the first game
				# Convert Rankings to Binary Values
				engagementRanking_A = toBinary(format_line[1])
				frustrationRanking_A = toBinary(format_line[2])
				challengeRanking_A = toBinary(format_line[3])
				engagementRanking_B = toBinary(format_line[4])
				frustrationRanking_B = toBinary(format_line[5])
				challengeRanking_B = toBinary(format_line[6])
			
			line = pref_data.readline()
			
		# Demographic data
		dem_filePath = mypath + "\\" + dir + "\\" + "Dem.csv"
		dem_data = open(dem_filePath, "r+")
		line = dem_data.readline()
		format = line.split(",")
		playedBefore = format[0]
		timePlayingGames = format[1]
		playGames = format[2]
		age = format[3]	
		
		# Write all metrics to the the process file
		outputFileProcessed.write(	
									str(win_A) + "," +
									str(powerUpSum_A) + "," +
									str(numDeaths_A) + "," +
									str(totalTime_A) + "," +
									str(win_B) + "," +
									str(powerUpSum_B) + "," +
									str(numDeaths_B) + "," +
									str(totalTime_B) + "," +
									age + "," +
									playedBefore + "," +
									timePlayingGames + "," +
									playGames + "," +
									str(pairsPlayed) + "," +
									engagementRanking_A + "," +
									frustrationRanking_A + "," +
									challengeRanking_A + "," +
									engagementRanking_B + "," +
									frustrationRanking_B + "," +
									challengeRanking_B +
									"\n"
								)
		