/**
 * File: MatchControl.java
 * Project: CMSC 331 Project Part 1 Fall 2017
 * Author: Brendan Jones
 * Date: 12-9-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * The main file for the card game. Has-a relationship with Game. Has game run desired amount of times and prints out results
 * to a file entitled results.txt.
 */

import java.io.FileNotFoundException;
import java.io.FileOutputStream;
import java.io.PrintWriter;
import java.util.Random;

public class MatchControl
{
	private static int m_numOfGames;//The total number of games played, random 1-40 inclusive
	private static int[] m_player1Matches;//The number of matches player 1 made in each game
	private static int[] m_player2Matches;//The number of matches player 2 made in each game
	private static int[] m_player1BiggestStreak;//The biggest streak player 1 went on in each game
	private static int[] m_player2BiggestStreak;//The biggest streak player 2 went on in each game
	private static int[] m_totalGuesses;//The total number of guesses by both players
	private static Game m_currentGame;//The current game
	public static PrintWriter outputFile;
	
	/**
	 * The main function. Instantiates each variable, has the desired number of games run, gets desired info from each game,
	 * and has info print to a file.
	 * @param args
	 */
	public static void main(String[] args)
	{
		try
		{
			outputFile = new PrintWriter(new FileOutputStream("results.txt"));
		} catch (FileNotFoundException e)
		{
			e.printStackTrace();
		}
		
		Random rand = new Random();
		m_numOfGames = rand.nextInt(40) + 1;
		m_player1Matches = new int[m_numOfGames];
		m_player2Matches = new int[m_numOfGames];
		m_player1BiggestStreak = new int[m_numOfGames];
		m_player2BiggestStreak = new int [m_numOfGames];
		m_totalGuesses = new int[m_numOfGames];
		
		for (int i = 0; i < m_numOfGames; i++)
		{
			outputFile.println("Game # " + i + " !");
			m_currentGame = new Game();
			m_currentGame.playGame();
			
			m_player1Matches[i] = m_currentGame.getPlayer1Matches();
			m_player2Matches[i] = m_currentGame.getPlayer2Matches();
			m_player1BiggestStreak[i] = m_currentGame.getPlayer1BiggestStreak();
			m_player2BiggestStreak[i] = m_currentGame.getPlayer2BiggestStreak();	
			m_totalGuesses[i] = m_currentGame.getTotalGuesses();
		}
		
		printToFile();
	}
	
	/**
	 * Prints summary info to the screen for the user.
	 * Prints different, more detailed summary info to a file named results.txt to be read by a different program.  
	 */
	public static void printToFile()
	{
		System.out.println("Total number of games played = " + m_numOfGames);
		
		System.out.print("Average number of matches by player 1 = ");
		int totalMatches = 0;
		for (int i = 0; i < m_numOfGames; i++)
			totalMatches += m_player1Matches[i];
		System.out.print(totalMatches / m_numOfGames + "\nAverage number of matches by player 2 = ");
		
		totalMatches = 0;
		for (int i = 0; i < m_numOfGames; i++)
			totalMatches += m_player2Matches[i];
		System.out.print(totalMatches / m_numOfGames + "\nGreatest number of guesses = " );
		
		int greatestGuesses = -1;
		for (int i = 0; i < m_numOfGames; i++)
			if (m_totalGuesses[i] > greatestGuesses)
				greatestGuesses = m_totalGuesses[i];
		System.out.print(greatestGuesses + "\nLeast number of guesses = ");
		
		int leastGuesses = m_totalGuesses[0];
		for (int i = 1; i < m_numOfGames; i++)
			if (m_totalGuesses[i] < leastGuesses)
				leastGuesses = m_totalGuesses[i];
		System.out.print(leastGuesses + "\nAverage guesses per game = ");
		
		int totalGuess = 0;
		for (int i = 0; i < m_numOfGames; i++)
			totalGuess += m_totalGuesses[i];
		System.out.print(totalGuess / m_numOfGames + "\nLongest consecutive guess streak = ");
		
		int bestStreak = 0;
		for (int i = 0; i < m_numOfGames; i++)
			if (m_player1BiggestStreak[i] > bestStreak)
				bestStreak = m_player1BiggestStreak[i];
		for (int i = 0; i < m_numOfGames; i++)
			if (m_player2BiggestStreak[i] > bestStreak)
				bestStreak = m_player2BiggestStreak[i];
		System.out.println(bestStreak);
		
		int player1Wins = 0, player2Wins = 0;
		for (int i = 0; i < m_numOfGames; i++)
		{
			if (m_player1Matches[i] > m_player2Matches[i])
				player1Wins++;
			else if (m_player2Matches[i] > m_player1Matches[i])
				player2Wins++;
		}
		if (player1Wins > player2Wins)
			System.out.println("Player 1 had the most wins with " + player1Wins + " wins");
		else if (player2Wins > player1Wins)
			System.out.println("Player 2 had the most wins with " + player2Wins + " wins");
		else//Player 1 wins == player 2 wins
			System.out.println("Player 1 and player 2 both had " + player1Wins + " wins");
		
		
		
		outputFile.println("Number of games:");
		outputFile.println(m_numOfGames);
		outputFile.println("Number of matches found by player 1:");
		for (int i = 0; i < m_numOfGames; i++)
		{
			if (i < m_numOfGames - 1)
				outputFile.print(m_player1Matches[i] + " ");
			else
				outputFile.println(m_player1Matches[i]);
		}
		outputFile.println("Number of matches found by player 2:");
		for (int i = 0; i < m_numOfGames; i++)
		{
			if (i < m_numOfGames - 1)
				outputFile.print(m_player2Matches[i] + " ");
			else
				outputFile.println(m_player2Matches[i]);
		}
		outputFile.println("Number of guesses each round:");
		for (int i = 0; i < m_numOfGames; i++)
		{
			if (i < m_numOfGames - 1)
				outputFile.print(m_totalGuesses[i] + " ");
			else
				outputFile.println(m_totalGuesses[i]);
		}
		outputFile.println("Player 1's biggest streak each game:");
		for (int i = 0; i < m_numOfGames; i++)
		{
			if (i < m_numOfGames - 1)
				outputFile.print(m_player1BiggestStreak[i] + " ");
			else
				outputFile.println(m_player1BiggestStreak[i]);
		}
		outputFile.println("Player 2's biggest streak each game:");
		for (int i = 0; i < m_numOfGames; i++)
		{
			if (i < m_numOfGames - 1)
				outputFile.print(m_player2BiggestStreak[i] + " ");
			else
				outputFile.println(m_player2BiggestStreak[i]);
		}
		
		outputFile.close();
	}
}