/**
 * File: Game.java
 * Project: CMSC 331 Project Part 1 Fall 2017
 * Author: Brendan Jones
 * Date: 12-9-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * Creates and runs each game. Has-a relationship with Player. Uses outputFile from MatchControl.
 */

import java.util.Random;

public class Game
{
	private final int M_ROWS = 4;//The number of rows in the board
	private final int M_COLUMNS = 13;//The number of columns in the board 
	private int m_totalMatches = 0;//The total number of matches by both players
	private final int M_TOTAL_CARDS = 52;//The total number of cards in the game
	private int m_numOfGuesses = 0;//The total number of guesses by both players
	private boolean[][] m_seenCard = new boolean[M_ROWS][M_COLUMNS];//A 2D array of whether or not each card has been seen
	private Card[][] m_hiddenBoard = new Card[M_ROWS][M_COLUMNS];//A 2D array of the location of each card, hidden from players
	private Card[][] m_visibleBoard = new Card[M_ROWS][M_COLUMNS];//An 2D array representing
	private Player m_player1 = new Player();//Contains info on player 1
	private Player m_player2 = new Player();//Contains info on player 2
	
	/**
	 * The null constructor for Game. Instantiates m_hiddenBoard, m_visibleBoard, and m_seenCard. 
	 */
	public Game()
	{
		randomizeBoard();
		
		for (int i = 0; i < M_ROWS; i++)
		{
			for (int j = 0; j < M_COLUMNS; j++)
			{
				m_seenCard[i][j] = false;
				m_visibleBoard[i][j] = Card.OO;
			}
		}
	}
	
	/**
	 * Randomly creates a board of Cards.
	 */
	public void randomizeBoard()
	{
		Random rand = new Random();
		boolean[] insertedCard = new boolean[M_TOTAL_CARDS];
		for (int i = 0; i < M_TOTAL_CARDS; i++)
			insertedCard[i] = false;
		Card theCards[] = Card.values();
		
		for (int i = 0; i < M_ROWS; i++)
		{
			for (int j = 0; j < M_COLUMNS; j++)
			{
				int newCard;
				do
				{
					newCard = rand.nextInt(M_TOTAL_CARDS);
				} while (insertedCard[newCard]);//Repeat if card has been inserted
				
				m_hiddenBoard[i][j] = theCards[newCard];
				insertedCard[newCard] = true;
			}
		}
	}
	
	/**
	 * Manages the playing of each game
	 */
	public void playGame()
	{
		while (m_totalMatches < M_TOTAL_CARDS / 2)
		{
			MatchControl.outputFile.println("Total matches = " + m_totalMatches);
			while (m_totalMatches < M_TOTAL_CARDS / 2 && playPlayer1())
			{
				m_player1.incrementNumOfMatchedCards();
				m_player1.incrementCurrentStreak();
				m_totalMatches++;
			}
			m_player1.updateBestStreak();
			m_player1.resetCurrentStreak();
			
			while (m_totalMatches < M_TOTAL_CARDS / 2 && playPlayer2())
			{
				m_player2.incrementNumOfMatchedCards();
				m_player2.incrementCurrentStreak();
				m_totalMatches++;
			}
			m_player2.updateBestStreak();
			m_player2.resetCurrentStreak();
		}
		
		if (m_player1.getNumOfMatchedCards() > m_player2.getNumOfMatchedCards())
			MatchControl.outputFile.println("Congrats player 1, you won! You guessed " + m_player1.getNumOfMatchedCards() + " matches!");
		else if (m_player1.getNumOfMatchedCards() < m_player2.getNumOfMatchedCards())
			MatchControl.outputFile.println("Congrats player 2, you won! You guessed " + m_player2.getNumOfMatchedCards() + " matches!");
		else//Tied
			MatchControl.outputFile.println("Both players tied with " + m_player1.getNumOfMatchedCards() + " matches.");
	}
	
	/**
	 * Plays player 1. Guesses something unseen, or random if seen everything, then something random
	 * @return True if match made/found
	 */
	private boolean playPlayer1()
	{
		int row1, column1, row2, column2;
		Random rand = new Random();
		
		MatchControl.outputFile.println("Player 1's turn!");
		
		if (!seenAllCards())
		{
			do
			{
				row1 = rand.nextInt(M_ROWS);
				column1 = rand.nextInt(M_COLUMNS);
			} while (m_seenCard[row1][column1] || m_visibleBoard[row1][column1] == Card.XX);//Repeats if card seen or card matched
		}
		else
		{
			do
			{
				row1 = rand.nextInt(M_ROWS);
				column1 = rand.nextInt(M_COLUMNS);
			} while (m_visibleBoard[row1][column1] == Card.XX);//Repeats if card had previously been matched
		}
		
		do
		{//Repeat if card previously matched or if same as other card
			row2 = rand.nextInt(M_ROWS);
			column2 = rand.nextInt(M_COLUMNS);
		} while (m_visibleBoard[row2][column2] == Card.XX || (row1 == row2 && column1 == column2));
		
		m_visibleBoard[row1][column1] = m_hiddenBoard[row1][column1];
		m_visibleBoard[row2][column2] = m_hiddenBoard[row2][column2];
		MatchControl.outputFile.println("Cards selected:");
		displayBoard();
		
		m_seenCard[row1][column1] = m_seenCard[row2][column2] = true;
		m_numOfGuesses++;
		
		if (cardsAreMatch(m_hiddenBoard[row1][column1], m_hiddenBoard[row2][column2]) || cardsAreMatch(m_hiddenBoard[row2][column2], m_hiddenBoard[row1][column1]))
		{
			MatchControl.outputFile.println("Congrats player 1! You matched cards " + m_hiddenBoard[row1][column1] + " and " + m_hiddenBoard[row2][column2] + "!");
			m_visibleBoard[row1][column1] = m_visibleBoard[row2][column2] = Card.XX;
			return true;
		}
		else
		{
			m_visibleBoard[row1][column1] = m_visibleBoard[row2][column2] = Card.OO;
			return false;
		}
	}
	
	/**
	 * Plays player 2. Guesses something random, then uses memory if has seen and remembers match, random if not.
	 * If match was seen previously, 10% probability it "remembers" where the card was.
	 * @return True if match made
	 */
	private boolean playPlayer2()
	{
		int row1, column1, row2 = -1, column2 = -1;
		Random rand = new Random();
		
		MatchControl.outputFile.println("Player 2's turn!");
		
		do
		{
			row1 = rand.nextInt(M_ROWS);
			column1 = rand.nextInt(M_COLUMNS);
		} while (m_visibleBoard[row1][column1] == Card.XX);//Repeat if card already matched
		
		if (seenMatch(m_hiddenBoard[row1][column1]) && rand.nextInt() % 10 == 0)
		{
			Card temp = getMatch(m_hiddenBoard[row1][column1]);
			
			for (int i = 0; i < M_ROWS; i++)
			{
				for (int j = 0; j < M_COLUMNS; j++)
				{
					if (m_hiddenBoard[i][j] == temp)
					{
						row2 = i;
						column2 = j;
					}
				}
			}
			
			m_visibleBoard[row1][column1] = m_hiddenBoard[row1][column1];
			m_visibleBoard[row2][column2] = m_hiddenBoard[row2][column2];
			MatchControl.outputFile.println("Cards selected:");
			displayBoard();
			
			m_seenCard[row1][column1] = m_seenCard[row2][column2] = true;
			m_numOfGuesses++;
			
			MatchControl.outputFile.println("Congrats player 2! You matched cards " + m_hiddenBoard[row1][column1] + " and " + m_hiddenBoard[row2][column2] + "!");
			m_visibleBoard[row1][column1] = m_visibleBoard[row2][column2] = Card.XX;
			return true;
		}
		else
		{
			do
			{
				row2 = rand.nextInt(M_ROWS);
				column2 = rand.nextInt(M_COLUMNS);
			} while (m_visibleBoard[row2][column2] == Card.XX || (row1 == row2 && column1 == column2));
			
			m_visibleBoard[row1][column1] = m_hiddenBoard[row1][column1];
			m_visibleBoard[row2][column2] = m_hiddenBoard[row2][column2];
			MatchControl.outputFile.println("Cards selected:");
			displayBoard();
			
			m_seenCard[row1][column1] = m_seenCard[row2][column2] = true;
			m_numOfGuesses++;
			
			if (cardsAreMatch(m_hiddenBoard[row1][column1], m_hiddenBoard[row2][column2]) || cardsAreMatch(m_hiddenBoard[row2][column2], m_hiddenBoard[row1][column1]))
			{
				MatchControl.outputFile.println("Congrats player 2! You matched cards " + m_hiddenBoard[row1][column1] + " and " + m_hiddenBoard[row2][column2] + "!");
				m_visibleBoard[row1][column1] = m_visibleBoard[row2][column2] = Card.XX;
				return true;
			}
			else
			{
				m_visibleBoard[row1][column1] = m_visibleBoard[row2][column2] = Card.OO;
				return false;
			}
		}
	}
	
	/**
	 * Returns the number of matches player 1 got.
	 * @return The number of matches by player 1
	 */
	public int getPlayer1Matches()
	{
		return m_player1.getNumOfMatchedCards();
	}
	
	/**
	 * Returns the number of matches player 2 got.
	 * @return The number of matches by player 2
	 */
	public int getPlayer2Matches()
	{
		return m_player2.getNumOfMatchedCards();
	}
	
	/**
	 * Getter for m_numOfGuesses
	 * @return m_numOfGuesses The total number of guesses by both players
	 */
	public int getTotalGuesses()
	{
		return m_numOfGuesses;
	}
	
	/**
	 * Returns player 1's biggest streak
	 * @return Player 1's biggest streak
	 */
	public int getPlayer1BiggestStreak()
	{
		return m_player1.getBestStreak();
	}
	
	/**
	 * Returns player 2's biggest streak
	 * @return Player 2's biggest streak
	 */
	public int getPlayer2BiggestStreak()
	{
		return m_player2.getBestStreak();
	}
	
	/**
	 * Returns whether or not all cards have been seen
	 * @return True if all cards have been seen.
	 */
	private boolean seenAllCards()
	{
		for (int i = 0; i < M_ROWS; i++)
			for (int j = 0; j < M_COLUMNS; j++)
				if (!m_seenCard[i][j])
					return false;
		return true;
	}
	
	/**
	 * Finds the match of the passed card and checks to see if that card has been seen
	 * @param toCheck The Card to see if its match has been seen
	 * @return True if the passed card's match has been seen
	 */
	private boolean seenMatch(Card toCheck)
	{
		Card card2 = getMatch(toCheck);
		
		for (int i = 0; i < M_ROWS; i++)
			for (int j = 0; j < M_COLUMNS; j++)
				if (m_hiddenBoard[i][j] == card2)
					return m_seenCard[i][j];
		
		return false;
	}
	
	/**
	 * Checks to see if the 2 cards are matches. When you call, switch parameters to fully check the two cards.
	 * @param check1 One card to be checked
	 * @param check2 The other card to be checked
	 * @return True if cards are matched. May return false but switching parameters may return true.
	 */
	private boolean cardsAreMatch(Card check1, Card check2)
	{
		if (check1 == Card.HA && check2 == Card.DA)
			return true;
		else if (check1 == Card.H2 && check2 == Card.D2)
			return true;
		else if (check1 == Card.H3 && check2 == Card.D3)
			return true;
		else if (check1 == Card.H4 && check2 == Card.D4)
			return true;
		else if (check1 == Card.H5 && check2 == Card.D5)
			return true;
		else if (check1 == Card.H6 && check2 == Card.D6)
			return true;
		else if (check1 == Card.H7 && check2 == Card.D7)
			return true;
		else if (check1 == Card.H8 && check2 == Card.D8)
			return true;
		else if (check1 == Card.H9 && check2 == Card.D9)
			return true;
		else if (check1 == Card.HT && check2 == Card.DT)
			return true;
		else if (check1 == Card.HJ && check2 == Card.DJ)
			return true;
		else if (check1 == Card.HQ && check2 == Card.DQ)
			return true;
		else if (check1 == Card.HK && check2 == Card.DK)
			return true;
		else if (check1 == Card.CA && check2 == Card.SA)
			return true;
		else if (check1 == Card.C2 && check2 == Card.S2)
			return true;
		else if (check1 == Card.C3 && check2 == Card.S3)
			return true;
		else if (check1 == Card.C4 && check2 == Card.S4)
			return true;
		else if (check1 == Card.C5 && check2 == Card.S5)
			return true;
		else if (check1 == Card.C6 && check2 == Card.S6)
			return true;
		else if (check1 == Card.C7 && check2 == Card.S7)
			return true;
		else if (check1 == Card.C8 && check2 == Card.S8)
			return true;
		else if (check1 == Card.C9 && check2 == Card.S9)
			return true;
		else if (check1 == Card.CT && check2 == Card.ST)
			return true;
		else if (check1 == Card.CJ && check2 == Card.SJ)
			return true;
		else if (check1 == Card.CQ && check2 == Card.SQ)
			return true;
		else if (check1 == Card.CK && check2 == Card.SK)
			return true;
		else
			return false;
	}
	
	/**
	 * Returns the match of the passed Card.
	 * @param theCard The card to get the match of 
	 * @return The Card that's the match of the passed Card
	 */
	private Card getMatch(Card theCard)
	{
		switch(theCard)
		{
		case HA:
			return Card.DA;
		case H2:
			return Card.D2;
		case H3:
			return Card.D3;
		case H4:
			return Card.D4;
		case H5:
			return Card.D5;
		case H6:
			return Card.D6;
		case H7:
			return Card.D7;
		case H8:
			return Card.D8;
		case H9:
			return Card.D9;
		case HT:
			return Card.DT;
		case HJ:
			return Card.DJ;
		case HQ:
			return Card.DQ;
		case HK:
			return Card.DK;
		case DA:
			return Card.HA;
		case D2:
			return Card.H2;
		case D3:
			return Card.H3;
		case D4:
			return Card.H4;
		case D5:
			return Card.H5;
		case D6:
			return Card.H6;
		case D7:
			return Card.H7;
		case D8:
			return Card.H8;
		case D9:
			return Card.H9;
		case DT:
			return Card.HT;
		case DJ:
			return Card.HJ;
		case DQ:
			return Card.HQ;
		case DK:
			return Card.HK;
		case CA:
			return Card.SA;
		case C2:
			return Card.S2;
		case C3:
			return Card.S3;
		case C4:
			return Card.S4;
		case C5:
			return Card.S5;
		case C6:
			return Card.S6;
		case C7:
			return Card.S7;
		case C8:
			return Card.S8;
		case C9:
			return Card.S9;
		case CT:
			return Card.ST;
		case CJ:
			return Card.SJ;
		case CQ:
			return Card.SQ;
		case CK:
			return Card.SK;
		case SA:
			return Card.CA;
		case S2:
			return Card.C2;
		case S3:
			return Card.C3;
		case S4:
			return Card.C4;
		case S5:
			return Card.C5;
		case S6:
			return Card.C6;
		case S7:
			return Card.C7;
		case S8:
			return Card.C8;
		case S9:
			return Card.C9;
		case ST:
			return Card.CT;
		case SJ:
			return Card.CJ;
		case SQ:
			return Card.CQ;
		case SK:
			return Card.CK;
		default:
			MatchControl.outputFile.println("Error: Unrecognized card type in get match card!");
			return theCard;
		}
	}
	
	/**
	 * Prints out the contents of m_visibleBoard to the screen
	 */
	private void displayBoard()
	{
		for (int i = 0; i < M_ROWS; i++)
		{
			for (int j = 0; j < M_COLUMNS; j++)
			{
				if (j < M_COLUMNS - 1)
					MatchControl.outputFile.print(m_visibleBoard[i][j] + " ");
				else
					MatchControl.outputFile.println(m_visibleBoard[i][j]);
			}
		}
	}
}