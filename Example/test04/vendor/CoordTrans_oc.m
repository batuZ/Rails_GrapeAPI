// GCJ-02 坐标转换成 BD-09 坐标
+ (CLLocationCoordinate2D)MarsGS2BaiduGS:(CLLocationCoordinate2D)coordinate
{
    double x_pi = PI * 3000.0 / 180.0;
    double x = coordinate.longitude, y = coordinate.latitude;
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    double bd_lon = z * cos(theta) + 0.0065;
    double bd_lat = z * sin(theta) + 0.006;
    return CLLocationCoordinate2DMake(bd_lat, bd_lon);
}
 
// BD-09 坐标转换成 GCJ-02 坐标
+ (CLLocationCoordinate2D)BaiduGS2MarsGS:(CLLocationCoordinate2D)coordinate
{
    double x_pi = PI * 3000.0 / 180.0;
    double x = coordinate.longitude - 0.0065, y = coordinate.latitude - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    double gg_lon = z * cos(theta);
    double gg_lat = z * sin(theta);
    return CLLocationCoordinate2DMake(gg_lat, gg_lon);
}

// WGS-84 坐标转换成 BD-09 坐标
+ (CLLocationCoordinate2D)WorldGS2BaiduGS:(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D mars = [ALDGeocoder WorldGS2MarsGS:coordinate];
    CLLocationCoordinate2D baidu = [ALDGeocoder MarsGS2BaiduGS:mars];
    return baidu;
}
 
// BD-09 坐标转换成 WGS-84 坐标
+ (CLLocationCoordinate2D)BaiduGS2WorldGS:(CLLocationCoordinate2D)coordinate
{
    CLLocationCoordinate2D mars = [ALDGeocoder BaiduGS2MarsGS:coordinate];
    CLLocationCoordinate2D world = [ALDGeocoder MarsGS2WorldGS:mars];
    return world;
}

// WGS-84 坐标转换成 Sogou 坐标
+ (CLLocationCoordinate2D)WorldGS2SogouGS:(CLLocationCoordinate2D)coordinate
{
    const double ee = 0.082271854224939184;
    double lon = coordinate.longitude;
    double lat = coordinate.latitude;
    double dlon = [ALDGeocoder rad:CLIP(lon, -360, 360)];
    double dlat = [ALDGeocoder rad:CLIP(lat, -90, 90)];
    dlon = 6378206.4 * dlon;
    double sinphi = sin(dlat);
    double temp1, temp2;
    if((temp1 = 1.0 + sinphi) == 0.0){
        dlat = -1000000000;
    }else if((temp2 = 1.0 - sinphi) == 0.0){
        dlat = 1000000000;
    }else{
        double esinphi = ee * sinphi;
        dlat = 3189103.2000000002 * log((temp1 / temp2) * pow((1.0 - esinphi) / (1.0 + esinphi), ee));
    }
    return CLLocationCoordinate2DMake(dlat, dlon);
}
 
// Sogou 坐标转换成 WGS-84 坐标
+ (CLLocationCoordinate2D)SogouGS2WorldGS:(CLLocationCoordinate2D)coordinate
{
    const double ee = 1.5707963267948966;
    const double aa = 0.0033938814110493522;
    double lon = coordinate.longitude;
    double lat = coordinate.latitude;
    double dlon = lon / 6378206.4;
    double temp = -lat / 6378206.4;
    double chi;
    if(temp < -307){
        chi = ee;
    }else if(temp > 308){
        chi = -ee;
    }else{
        chi = ee - 2 * atan(exp(temp));
    }
    double chi2 = 2 * chi;
    double coschi2 = cos(chi2);
    double dlat = chi + sin(chi2) * (aa + coschi2 * (1.3437644537757259E-005 + coschi2 * (7.2964865099246009E-008 + coschi2 * 4.4551470401894685E-010)));
    double rlon = CLIP([ALDGeocoder deg:dlon], -360, 360);
    double rlat = CLIP([ALDGeocoder deg:dlat], -90, 90);
    return CLLocationCoordinate2DMake(rlat, rlon);
}

// World Geodetic System ==> Mars Geodetic System
+ (CLLocationCoordinate2D)WorldGS2MarsGS:(CLLocationCoordinate2D)coordinate
{
    // a = 6378245.0, 1/f = 298.3
    // b = a * (1 - f)
    // ee = (a^2 - b^2) / a^2;
    const double a = 6378245.0;
    const double ee = 0.00669342162296594323;
    
    if (outOfChina(coordinate.latitude, coordinate.longitude))
    {
        return coordinate;
    }
    double wgLat = coordinate.latitude;
    double wgLon = coordinate.longitude;
    double dLat = transformLat(wgLon - 105.0, wgLat - 35.0);
    double dLon = transformLon(wgLon - 105.0, wgLat - 35.0);
    double radLat = wgLat / 180.0 * PI;
    double magic = sin(radLat);
    magic = 1 - ee * magic * magic;
    double sqrtMagic = sqrt(magic);
    dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * PI);
    dLon = (dLon * 180.0) / (a / sqrtMagic * cos(radLat) * PI);
    
    return CLLocationCoordinate2DMake(wgLat + dLat, wgLon + dLon);
}
 
// Mars Geodetic System ==> World Geodetic System
+ (CLLocationCoordinate2D)MarsGS2WorldGS:(CLLocationCoordinate2D)coordinate
{
    double gLat = coordinate.latitude;
    double gLon = coordinate.longitude;
    CLLocationCoordinate2D marsCoor = [ALDGeocoder WorldGS2MarsGS:coordinate];
    double dLat = marsCoor.latitude - gLat;
    double dLon = marsCoor.longitude - gLon;
    return CLLocationCoordinate2DMake(gLat - dLat, gLon - dLon);
}

//WGS-84 坐标转换成 墨卡托 坐标
+ (CLLocationCoordinate2D)WorldGS2Mercator:(CLLocationCoordinate2D)coordinate
{
    double lon = coordinate.longitude*20037508.34/180;
    double lat = log(tan((90+coordinate.latitude)*M_PI/360))/(M_PI/180);
    lat = lat*20037508.34/180;
    return CLLocationCoordinate2DMake(lat, lon);
}
 
//墨卡托 坐标转换成 WGS-84 坐标
+ (CLLocationCoordinate2D)Mercator2WorldGS:(CLLocationCoordinate2D)mercator
{
    double lon = mercator.longitude/20037508.34*180;
    double lat = mercator.latitude/20037508.34*180;
    lat = 180/M_PI*(2*atan(exp(lat*M_PI/180))-M_PI/2);
    return CLLocationCoordinate2DMake(lat, lon);
}


     w:
     latitude    CLLocationDegrees    4851981.4172018804
     longitude    CLLocationDegrees    116.08799621838706
     
     e:
     latitude    CLLocationDegrees    4855022.4620532598
     longitude    CLLocationDegrees    12992040.394812275
     
     n:
     latitude    CLLocationDegrees    4891929.6882040696
     longitude    CLLocationDegrees    12950848.060007252
     
     s:
     latitude    CLLocationDegrees    4823229.7204252267
     longitude    CLLocationDegrees    12956446.347120021