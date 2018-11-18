/**
 * File: Card.java
 * Project: CMSC 331 Project Part 1 Fall 2017
 * Author: Brendan Jones
 * Date: 12-9-17
 * Class Section: 3
 * Email: bjones10@umbc.edu
 * 
 * An enumeration containing each type of card plus OO which is a face down card and XX which is a removed matched card.
 * OO & XX are used only in the visible board.
 * Used by Game.
 */

public enum Card
{
	DA, D2, D3, D4, D5, D6, D7, D8, D9, DT, DJ, DQ, DK,
	HA, H2, H3, H4, H5, H6, H7, H8, H9, HT, HJ, HQ, HK,
	SA, S2, S3, S4, S5, S6, S7, S8, S9, ST, SJ, SQ, SK,
	CA, C2, C3, C4, C5, C6, C7, C8, C9, CT, CJ, CQ, CK,
	OO, XX
}