import { getNamedAccounts, deployments } from "hardhat";
import { verify } from "../helpers/verify";

const TOKEN_NAME = "ERC20Token";
const TOKEN_SYMBOL = "E20T";
const DECIMALS = 18;
const INITIAL_SUPPLY = 10;

async function deployFunction() {
  const { deploy } = deployments;
  const { deployer } = await getNamedAccounts();
  const args = [TOKEN_NAME, TOKEN_SYMBOL, DECIMALS, INITIAL_SUPPLY];
  const erc20Token = await deploy(TOKEN_NAME, {
    from: deployer,
    log: true,
    args: args,
    waitConfirmations: 6,
  });
  console.log(`${TOKEN_NAME} deployed at: ${erc20Token.address}`);
  await verify(erc20Token.address, args);
}

deployFunction()
  .then(() => process.exit(0))
  .catch((error) => {
    console.error(error);
    process.exit(1);
  });
