package com.winter.app.general;

import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.security.core.parameters.P;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;


import org.springframework.web.servlet.ModelAndView;

import java.util.HashMap;
import java.util.List;

import java.util.Map;

@Controller
@Slf4j
@RequestMapping("/general")
public class GeneralController {

    @Autowired
    GeneralService generalService;


    @PostMapping("cateAdd")
    @ResponseBody
    public int cateAdd(@RequestBody ProCategoryVO proCategoryVO)throws Exception{
        return generalService.cateAdd(proCategoryVO);
    }
    @PostMapping("carUpdate")
    @ResponseBody
    public int updateCar(@RequestBody CarDetailVO carDetailVO) throws Exception{

        return generalService.updateCar(carDetailVO);
    }

    @PostMapping("carDelete")
    @ResponseBody
    public int deleteCar(@RequestBody CarDetailVO carDetailVO) throws Exception{

        return generalService.deleteCar(carDetailVO);
    }

    @PostMapping("proDelete")
    @ResponseBody
    public int deletePro(@RequestBody PropertyVO propertyVO) throws Exception{

        return generalService.deletePro(propertyVO);
    }

    @PostMapping("proUpdate")
    @ResponseBody
    public int updatePro(@RequestBody PropertyVO propertyVO) throws Exception{
        return generalService.updatePro(propertyVO);
    }

    @GetMapping("carManage")
    public String getRequestPage(){
        return "general/CarManageAgree";
    }

    @GetMapping("property")
    public ModelAndView getPropertyPage(ModelAndView mv) throws Exception{
        mv.setViewName("general/PropertyList");
        mv.addObject("pro_cate", generalService.getCate());
        mv.addObject("car_type", generalService.getCarType());

        return mv;
    }

    @GetMapping("property/list")
    @ResponseBody
    public Map<String, Object> getPropertyList(Long code) throws Exception{
        PropertyVO propertyVO = new PropertyVO();
        propertyVO.setPro_category(code);
        Map<String, Object> response = new HashMap<>();
        response.put("data", generalService.getPropertyList(propertyVO));
        return response;
    }

    @PostMapping("carManage")
    @ResponseBody
    public int updateCarManage(CarManageVO carManageVO) throws Exception{
        return generalService.updateCarManage(carManageVO);
    }

    @PostMapping("carManage/delete")
    @ResponseBody
    public int deleteCarManage(CarManageVO carManageVO) throws Exception{
        return generalService.deleteCarManage(carManageVO);
    }

    @GetMapping("carManage/list")
    @ResponseBody
    public Map<String, Object> getManageList() throws Exception{
        Map<String, Object> response = new HashMap<>();
        response.put("data",generalService.getManageList());
        return response;
    }

    @PostMapping("carAllocation")
    @ResponseBody
    public CarManageVO carAllocation (@RequestBody CarManageVO carManageVO) throws Exception{
        carManageVO = generalService.carAllocation(carManageVO);


        return carManageVO;
    }

    
    @PostMapping("getUsableList")
	@ResponseBody
	public List<CarDetailVO> getUsableList(@RequestBody CarManageVO carManageVO) throws Exception{

		return generalService.getUsableList(carManageVO);
		
	}


    @PostMapping("getCarNumber")
    @ResponseBody
    public CarDetailVO postMethodName(@RequestBody CarDetailVO carDetailVO) throws Exception {

        carDetailVO = generalService.getCarNumber(carDetailVO);

        return carDetailVO;
    }

    @PostMapping("getAllocationState")
    @ResponseBody
    public Map<String,Object> getAllocationState(@RequestBody CarManageVO carManageVO) throws Exception{
    	Map<String, Object> map = generalService.getAllocationState(carManageVO);
    	
    	return map;
    	
    }
    
    

}
