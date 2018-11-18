/**
 * File: Player.java
 * Project: CMSC 331 Project Part 1 Fall 2017
 * Author: Brendan Jones
 * Date: 12-9-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * Manages the number of matched cards, the current streak, and the best streak for the player.
 * Each Game uses new 2 new players.
 */

public class Player
{
	private int m_matchedCards;//The number of pairs the player has matched
	private int m_currentStreak;//The player's current streak
	private int m_bestStreak;//The player's best streak
	
	/**
	 * The null constructor for Player. Initializes the variables to 0.
	 */
	public Player()
	{
		m_matchedCards = m_currentStreak = m_bestStreak = 0;
	}
	
	/**
	 * The getter for m_matchedCards
	 * @return m_matchedCards The number of pairs the player has matched
	 */
	public int getNumOfMatchedCards()
	{
		return m_matchedCards;
	}
	
	/**
	 * Increases m_matchedCards by 1
	 */
	public void incrementNumOfMatchedCards()
	{
		m_matchedCards++;
	}
	
	/**
	 * Getter for m_currentStreak
	 * @return m_currentStreak The length of the streak the player currently is on
	 */
	public int getCurrentStreak()
	{
		return m_currentStreak;
	}
	
	/**
	 * Increases m_currentStreak by 1
	 */
	public void incrementCurrentStreak()
	{
		m_currentStreak++;
	}
	
	/**
	 * Resets m_currentStreak to 0
	 */
	public void resetCurrentStreak()
	{
		m_currentStreak = 0;
	}
	
	/**
	 * Getter for m_bestStreak
	 * @return m_bestStreak The best streak the player has gone on
	 */
	public int getBestStreak()
	{
		return m_bestStreak;
	}
	
	/**
	 * If the player currently is on a longer streak than m_bestStreak, updates m_bestStreak 
	 */
	public void updateBestStreak()
	{
		if (getCurrentStreak() > m_bestStreak)
			m_bestStreak = m_currentStreak;
	}
}