package com.cxy.pojo;

import lombok.AllArgsConstructor;
import lombok.Data;
import lombok.NoArgsConstructor;

/**
 * @author 陈翔宇
 * Date  2025/7/9 14:21
 */
@Data
@AllArgsConstructor
@NoArgsConstructor
public class ProfessionalTitles {
    private Integer id;
    private String titleName;
    private String description;
}
