function _createKitty(
        uint256 _momId,     // why all of these entered as uint256 and all of their counterparty below as uint64, 32 and 16??
        uint256 _dadId,
        uint256 _generation,
        uint256 _genes,
        address _owner
    ) private returns (uint256) {
        Kitty memory _kitty = Kitty({
            genes: _genes,
            birthTime: uint64(now),
            momId: uint32(_momId),
            dadId: uint32(_dadId),
            generation: uint16(_generation)
        });

        uint256 newKittenId = kitties.push(_kitty) -1;

        emit Birth(_owner, newKittenId, _momId, _dadId, _genes);

        _transfer(address(0), _owner, newKittenId);

        return newKittenId;
    } 

    function getKitty (uint256 _id) external view returns (
        uint256 genes;
        uint256 birthTime;
        uint256 momId;
        uint256 dadId;
        uint256 generation; 
    ) 
    {
        Kitty storage kitty = kitties[_id];

        genes = kitty.genes;   
        birthTime = uint256(kitty.birthTime);   // why the need for conversion back to uint256 of these?
        momId = uint256(kitty.momId);
        dadId = uint256(kitty.dadId);
        generation = uint256(kitty.generation);    
    }