/*
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */
package com.cyrus.dtos;

/**
 *
 * @author Cyrus
 */
public class DiscountErrorObj {

    private String codeNameLengthError;
    private String discountPercentTypeError;
    private String discountPercentSizeError;
    private String duplicateCodeNameError;
    private String expiryDateIsInvalid;

    public DiscountErrorObj() {
    }

    /**
     * @return the codeNameLengthError
     */
    public String getCodeNameLengthError() {
        return codeNameLengthError;
    }

    /**
     * @param codeNameLengthError the codeNameLengthError to set
     */
    public void setCodeNameLengthError(String codeNameLengthError) {
        this.codeNameLengthError = codeNameLengthError;
    }

    /**
     * @return the discountPercentTypeError
     */
    public String getDiscountPercentTypeError() {
        return discountPercentTypeError;
    }

    /**
     * @param discountPercentTypeError the discountPercentTypeError to set
     */
    public void setDiscountPercentTypeError(String discountPercentTypeError) {
        this.discountPercentTypeError = discountPercentTypeError;
    }

    /**
     * @return the discountPercentSizeError
     */
    public String getDiscountPercentSizeError() {
        return discountPercentSizeError;
    }

    /**
     * @param discountPercentSizeError the discountPercentSizeError to set
     */
    public void setDiscountPercentSizeError(String discountPercentSizeError) {
        this.discountPercentSizeError = discountPercentSizeError;
    }

    /**
     * @return the duplicateCodeNameError
     */
    public String getDuplicateCodeNameError() {
        return duplicateCodeNameError;
    }

    /**
     * @param duplicateCodeNameError the duplicateCodeNameError to set
     */
    public void setDuplicateCodeNameError(String duplicateCodeNameError) {
        this.duplicateCodeNameError = duplicateCodeNameError;
    }

    /**
     * @return the expiryDateIsInvalid
     */
    public String getExpiryDateIsInvalid() {
        return expiryDateIsInvalid;
    }

    /**
     * @param expiryDateIsInvalid the expiryDateIsInvalid to set
     */
    public void setExpiryDateIsInvalid(String expiryDateIsInvalid) {
        this.expiryDateIsInvalid = expiryDateIsInvalid;
    }

}
