    <?php
       $json = file_get_contents('https://api.genelpara.com/embed/para-birimleri.json');
       $data = json_decode($json, true);
       
       $newData = array();
       
       $units = array("USD", "EUR", "GBP", "GA", "C", "GAG", "BTC", "ETH", "XU100");
       
       foreach ($units as $unit) {
           $newData[] = array(
               "tur" => $unit,
               "satis" => $data[$unit]["satis"],
               "alis" => $data[$unit]["alis"],
               "degisim" => $data[$unit]["degisim"],
               "d_oran" => isset($data[$unit]["d_oran"]) ? $data[$unit]["d_oran"] : null,
               "d_yon" => isset($data[$unit]["d_yon"]) ? $data[$unit]["d_yon"] : null
           );
       }
       
       $newJson = json_encode($newData);
       
       echo $newJson;
       

        
    ?>