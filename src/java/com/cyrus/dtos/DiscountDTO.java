/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

import java.io.Serializable;
import java.sql.Date;

/**
 *
 * @author Cyrus
 */
public class DiscountDTO implements Serializable {

    private int codeId;
    private String codeName;
    private int discountPercent;
    private Date dateCreate;
    private Date expiryDate;

    public DiscountDTO() {
    }

    public DiscountDTO(int codeId, String codeName, int discountPercent, Date dateCreate, Date expiryDate) {
        this.codeId = codeId;
        this.codeName = codeName;
        this.discountPercent = discountPercent;
        this.dateCreate = dateCreate;
        this.expiryDate = expiryDate;
    }

    /**
     * @return the codeId
     */
    public int getCodeId() {
        return codeId;
    }

    /**
     * @param codeId the codeId to set
     */
    public void setCodeId(int codeId) {
        this.codeId = codeId;
    }

    /**
     * @return the codeName
     */
    public String getCodeName() {
        return codeName;
    }

    /**
     * @param codeName the codeName to set
     */
    public void setCodeName(String codeName) {
        this.codeName = codeName;
    }

    /**
     * @return the discountPercent
     */
    public int getDiscountPercent() {
        return discountPercent;
    }

    /**
     * @param discountPercent the discountPercent to set
     */
    public void setDiscountPercent(int discountPercent) {
        this.discountPercent = discountPercent;
    }

    /**
     * @return the dateCreate
     */
    public Date getDateCreate() {
        return dateCreate;
    }

    /**
     * @param dateCreate the dateCreate to set
     */
    public void setDateCreate(Date dateCreate) {
        this.dateCreate = dateCreate;
    }

    /**
     * @return the expiryDate
     */
    public Date getExpiryDate() {
        return expiryDate;
    }

    /**
     * @param expiryDate the expiryDate to set
     */
    public void setExpiryDate(Date expiryDate) {
        this.expiryDate = expiryDate;
    }

}
