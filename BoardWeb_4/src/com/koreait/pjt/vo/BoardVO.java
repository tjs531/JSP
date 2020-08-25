package com.koreait.pjt.vo;

public class BoardVO {
	private int i_board;
	private String title;
	private String ctnt;
	private int hits;
	private int i_user;
	private String nm;
	private String r_dt;
	private String m_dt;
	private int yn_like;
	private int yn_hate;
	private int c_like;
	
	public String getNm() {
		return nm;
	}
	public void setNm(String nm) {
		this.nm = nm;
	}
	public int getI_board() {
		return i_board;
	}
	public void setI_board(int i_board) {
		this.i_board = i_board;
	}
	public String getTitle() {
		return title;
	}
	public void setTitle(String title) {
		this.title = title;
	}
	public String getCtnt() {
		return ctnt;
	}
	public void setCtnt(String ctnt) {
		this.ctnt = ctnt;
	}
	public int getHits() {
		return hits;
	}
	public void setHits(int hits) {
		this.hits = hits;
	}
	public int getI_user() {
		return i_user;
	}
	public void setI_user(int i_user) {
		this.i_user = i_user;
	}
	public String getR_dt() {
		return r_dt;
	}
	public void setR_dt(String r_dt) {
		this.r_dt = r_dt;
	}
	public String getM_dt() {
		return m_dt;
	}
	public void setM_dt(String m_dt) {
		this.m_dt = m_dt;
	}
	public int getYn_like() {
		return yn_like;
	}
	public void setYn_like(int yn_like) {
		this.yn_like = yn_like;
	}
	public int getYn_hate() {
		return yn_hate;
	}
	public void setYn_hate(int yn_hate) {
		this.yn_hate = yn_hate;
	}
	
	public int getC_like() {
		return c_like;
	}
	public void setC_like(int c_like) {
		this.c_like = c_like;
	}
	
	
}
