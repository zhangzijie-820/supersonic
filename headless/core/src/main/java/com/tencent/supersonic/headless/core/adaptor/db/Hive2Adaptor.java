package com.tencent.supersonic.headless.core.adaptor.db;

import com.tencent.supersonic.common.pojo.Constants;
import com.tencent.supersonic.common.pojo.enums.TimeDimensionEnum;

public class Hive2Adaptor extends BaseDbAdaptor {
    @Override
    public String getDateFormat(String dateType, String dateFormat, String column) {
        if (dateFormat.equalsIgnoreCase(Constants.DAY_FORMAT_INT)) {
            if (TimeDimensionEnum.MONTH.name().equalsIgnoreCase(dateType)) {
                return "date_format(" + column + ", 'yyyy-MM')";
            } else if (TimeDimensionEnum.WEEK.name().equalsIgnoreCase(dateType)) {
                return "date_format(date_sub("
                        + column
                        + ", "
                        + "(dayofweek("
                        + column
                        + ") - 2)), 'yyyy-MM-dd')";
            } else {
                return "date_format(from_unixtime(unix_timestamp("
                        + column
                        + ", 'yyyyMMdd')), 'yyyy-MM-dd')";
            }
        } else if (dateFormat.equalsIgnoreCase(Constants.DAY_FORMAT)) {
            if (TimeDimensionEnum.MONTH.name().equalsIgnoreCase(dateType)) {
                return "date_format(" + column + ", 'yyyy-MM')";
            } else if (TimeDimensionEnum.WEEK.name().equalsIgnoreCase(dateType)) {
                return "date_format(date_sub("
                        + column
                        + ", "
                        + "(dayofweek("
                        + column
                        + ") - 2)), 'yyyy-MM-dd')";
            } else {
                return column;
            }
        }
        return column;
    }

    @Override
    public String functionNameCorrector(String sql) {
        return sql;
    }
}
